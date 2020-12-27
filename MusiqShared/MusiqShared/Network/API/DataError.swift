//
//  DataError.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation

enum DataError: Error {
    case invalidRequest
    case invalidResponse
    case parsing(description: String)
    case network(description: String)
}
