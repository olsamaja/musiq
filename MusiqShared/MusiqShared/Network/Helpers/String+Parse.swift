//
//  String+Parse.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 31/03/2021.
//

import Combine

public extension String {
    
    func parse<T>() -> AnyPublisher<T, DataError> where T: Decodable {
        return Data(self.utf8).decode()
    }
    
}
