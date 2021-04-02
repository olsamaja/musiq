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
    
    public func loadData<T>(with components: URLComponents) -> AnyPublisher<T, DataError> where T: Decodable {
        
        guard let url = components.url else {
            let error = DataError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.execute(URLRequest(url: url))
    }
}
