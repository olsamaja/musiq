//
//  URLSession+Extensions.swift
//  MusiqNetwork
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import Combine
import MusiqCore

extension URLSession {
    
    func execute<T: Decodable>(_ request: URLRequest,
                               resultQueue: DispatchQueue = .main) -> AnyPublisher<T, DataError> {
        
        OLLogger.info("URLRequest: \(String(describing: request.url?.absoluteURL))")
        
        return self.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap() { pair in
                pair.data.decode()
            }
            .receive(on: resultQueue)
            .eraseToAnyPublisher()
    }
}
