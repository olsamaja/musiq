//
//  DataError.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation

public enum DataError: Error {
    case invalidRequest
    case invalidResponse
    case parsing(description: String)
    case network(description: String)
}

extension DataError: Equatable {}
