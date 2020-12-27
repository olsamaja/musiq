//
//  Configuration.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import MusiqCore

public struct Configuration {
    let scheme: Scheme
    let host: String
    let path: String
    let key: String
    
    enum Scheme: String {
        case http
        case https
    }
}
