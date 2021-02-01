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
    @Injected var configuration: Configuration
  
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - Configurable

extension DataFetcher: ConfigurableProtocol {
    
    func configure(with configuration: Configuration) {
//        self.configuration = configuration
    }
}

// MARK: - Private extensions

private extension DataFetcher {
    
    enum LastFmAPI {
        static let scheme = "https"
        static let host = "ws.audioscrobbler.com"
        static let path = "/2.0/"
        static let key = "a7698279d4bc40eba58c2338961937c1"
    }
    
    func makeDefaultComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = LastFmAPI.scheme
        components.host = LastFmAPI.host
        components.path = LastFmAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: LastFmAPI.key),
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
        OLLogger.info("configuration.host = \(configuration.host)")
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
