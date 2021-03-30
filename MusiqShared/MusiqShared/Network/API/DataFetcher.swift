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

public final class DataFetcher {
    
    private let session: URLSession
    @OptionalInjected var configuration: Configuration?
    
    public init(session: URLSession = .shared) {
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
}

public extension DataFetcher {
    
    // MARK: - Helpers

    private func makeTopTagsComponents() -> URLComponents {
        return makeComponents(with: ["method": "chart.gettoptags"])
    }

    private func makeArtistInfoComponents(artist: String) -> URLComponents {
        return makeComponents(with: ["method": "artist.getinfo", "artist": artist])
    }
    
    func makeComponents(with queryItems: [String: String]) -> URLComponents {
        var components = makeDefaultComponents()
        queryItems.forEach { components.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        return components
    }

    func loadData<T>(with components: URLComponents) -> AnyPublisher<T, DataError> where T: Decodable {
        
        guard let url = components.url else {
            let error = DataError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.execute(URLRequest(url: url))
    }
}
