//
//  ConfigurationServices+Injection.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 22/01/2021.
//

import MusiqCore
import Resolver

public extension Resolver {
    
    static func registerConfigurationServices(with bundle: Bundle) {
        do {
            let configuration = try ConfigurationDataProvider.load(with: bundle)
            register { configuration as Configuration }
        } catch {
            OLLogger.info("\(error) - Unable to load configuration")
        }
    }
}
