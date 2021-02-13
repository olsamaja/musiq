//
//  RepositoryProtocol.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    associatedtype T
    
    func getAll() -> AnyPublisher<[T], DataError>
}
