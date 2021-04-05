//
//  Configuration.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import MusiqCore

public struct Configuration {
    
    public enum Scheme: String {
        case http
        case https
    }
    
    public let scheme: Scheme
    public let host: String
    public let path: String
    public let key: String
    
}

extension Configuration.Scheme: CaseIterable {
    
    init?(string: String) {
        for value in Configuration.Scheme.allCases where "\(value)" == string {
            self = value
            return
        }
        
        return nil
    }
}
