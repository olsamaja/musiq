//
//  ApiDataNetworkConfiguration.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation
import MusiqCore

public struct ApiDataNetworkConfiguration {
    
    enum Scheme: String {
        case http
        case https
        
        static let `default` = Scheme.https
    }
    
    let scheme: Scheme
    let host: String
    let path: String
    let key: String
    
    init?(with bundle: Bundle) {
        guard let schemeString = bundle.infoForKey("MSQ_API_SCHEME"),
              let host = bundle.infoForKey("MSQ_API_HOST"),
              let path = bundle.infoForKey("MSQ_API_PATH"),
              let key = bundle.infoForKey("MSQ_API_KEY")
        else {
            return nil
        }
        
        self.scheme = Scheme(rawValue: schemeString) ?? .default
        self.host = host
        self.path = path
        self.key = key
    }
}
