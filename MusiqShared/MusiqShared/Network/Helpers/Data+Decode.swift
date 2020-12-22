//
//  Data+Decode.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import Combine

extension Data {
    
    func decode<T: Decodable>() -> AnyPublisher<T, DataError> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        self.debugPrintJSONString()
        
        return Just(self)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
