//
//  Configuration.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import MusiqCore

public struct Configuration {
    
    enum Scheme {
        case http
        case https
    }
    
    public let scheme: String
    public let host: String
    public let path: String
    public let key: String
    
}
