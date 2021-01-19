//
//  SearchArtistsDataProvider.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 16/01/2021.
//
// Source: https://medium.com/@nfrugoni19/protocol-oriented-dependency-injection-with-swift-605b3d5b72ce

import Foundation
import MusiqConfiguration
import MusiqCore

public struct SearchArtistsDataProvider {
    
    func search(with term: String) throws -> [Artist] {
        return []
    }
    
}
