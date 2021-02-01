//
//  AppServices+Injection.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 22/01/2021.
//

import MusiqConfiguration
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerConfigurationServices(with: Bundle.main)
    }
}
