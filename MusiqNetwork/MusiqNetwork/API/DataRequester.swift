//
//  DataRequester.swift
//  MusiqNetwork
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import Combine
import MusiqConfiguration
import MusiqCore
import Resolver

public final class DataRequester {
    
    @OptionalInjected var session: URLSession?
    @OptionalInjected var configuration: Configuration?
    
    public static var shared = DataRequester()
    
    public init() {}
    
    public func loadData<T>(with components: URLComponents) -> AnyPublisher<T, DataError> where T: Decodable {
        
        guard let url = components.url else {
            let error = DataError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlSession = session ?? URLSession.shared
        return urlSession.execute(URLRequest(url: url))
    }
}
