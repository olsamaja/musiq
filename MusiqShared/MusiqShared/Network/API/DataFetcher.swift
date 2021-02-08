//
//  DataFetcher.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import Combine
import MusiqConfiguration
import MusiqCore
import Resolver

final class DataFetcher {
    
    private let session: URLSession
    @OptionalInjected var configuration: Configuration?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - Private extensions

private extension DataFetcher {
    
    func makeDefaultComponents() -> URLComponents {
        
        var components = URLComponents()
        
        guard let configuration = configuration else {
            return components
        }
        
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.path = configuration.path
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: configuration.key),
            URLQueryItem(name: "format", value: "json")
        ]
        
        return components
    }
    
    func makeComponents(with queryItems: [String: String]) -> URLComponents {
        var components = makeDefaultComponents()
        queryItems.forEach { components.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        return components
    }
}

extension DataFetcher {
    
    func searchArtists(term: String) -> AnyPublisher<SearchArtistsDTO, DataError> {
        return loadData(with: makeSearchArtistsComponents(term: term))
    }
    
    // MARK: - Helpers

    private func makeTopTagsComponents() -> URLComponents {
        return makeComponents(with: ["method": "chart.gettoptags"])
    }

    private func makeSearchArtistsComponents(term: String) -> URLComponents {
        return makeComponents(with: ["method": "artist.search", "artist": term])
    }

    private func makeSearchTracksComponents(term: String) -> URLComponents {
        return makeComponents(with: ["method": "track.search", "track": term])
    }

    private func makeArtistInfoComponents(artist: String) -> URLComponents {
        return makeComponents(with: ["method": "artist.getinfo", "artist": artist])
    }

    private func loadData<T>(with components: URLComponents) -> AnyPublisher<T, DataError> where T: Decodable {
        
        guard let url = components.url else {
            let error = DataError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.execute(URLRequest(url: url))
    }
}
