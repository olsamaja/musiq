//
//  NetworkServices+Injection.swift
//  MusiqNetwork
//
//  Created by Olivier Rigault on 24/05/2021.
//

import MusiqCore
import Resolver

public extension Resolver {
    
    static func registerNetworkServices() {
        register { URLSession.shared as URLSession }
    }
}
