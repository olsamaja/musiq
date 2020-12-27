//
//  ConfigurationDTO.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 26/12/2020.
//

import Foundation

public struct ConfigurationDTO {

    let scheme: String?
    let host: String?
    let path: String?
    let key: String?

    init(with bundle: Bundle) {
        scheme = bundle.infoForKey("MSQ_API_SCHEME")
        host = bundle.infoForKey("MSQ_API_HOST")
        path = bundle.infoForKey("MSQ_API_PATH")
        key = bundle.infoForKey("MSQ_API_KEY")
    }
    
    init(scheme: String?, host: String?, path: String?, key: String?) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.key = key
    }
}
