//
//  String+Extensions.swift
//  MusiqSharedTests
//
//  Created by Olivier Rigault on 16/01/2021.
//

import Foundation
import Combine
@testable import MusiqShared
@testable import MusiqCore

extension String {
    
    func parse<T>() -> AnyPublisher<T, DataError> where T: Decodable {
        return Data(self.utf8).decode()
    }
    
}
