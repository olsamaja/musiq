//
//  ModuleArtistsServices+Injection.swift
//  MusiqModuleArtists
//
//  Created by Olivier Rigault on 03/04/2021.
//

import MusiqCore
import Resolver

public extension Resolver {
    
    static func registerModuleArtistsServices() {
        register { ArtistsViewModel() as ArtistsViewModel }
    }
}
