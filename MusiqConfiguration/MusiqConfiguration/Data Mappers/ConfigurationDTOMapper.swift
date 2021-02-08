//
//  ConfigurationDTOMapper.swift
//  MusiqConfiguration
//
//  Created by Olivier Rigault on 27/12/2020.
//

import Foundation
import MusiqCore

public struct ConfigurationDTOMapper {
    
    enum ValidationError: Error {
        case empty(_ property: Property)
        case invalid(_ property: Property)

        enum Property: String {
            case scheme
            case host
            case path
            case key
        }
    }

    static func map(_ dto: ConfigurationDTO) throws -> Configuration {
        
        guard let scheme = dto.scheme else { throw ValidationError.empty(.scheme) }
        guard let host = dto.host else { throw ValidationError.empty(.host) }
        guard let path = dto.path else { throw ValidationError.empty(.path) }
        guard let key = dto.key else { throw ValidationError.empty(.key) }
        
        return Configuration(scheme: scheme, host: host, path: path, key: key)
    }
    
}
