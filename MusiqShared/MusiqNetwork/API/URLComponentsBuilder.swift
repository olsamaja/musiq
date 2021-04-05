//
//  URLComponentsBuilder.swift
//  MusiqNetwork
//
//  Created by Olivier Rigault on 03/04/2021.
//

import Foundation
import Combine
import MusiqConfiguration
import MusiqCore
import Resolver

public final class URLComponentsBuilder: BuilderProtocol {
    
    @OptionalInjected var configuration: Configuration?

    var queryItems = [URLQueryItem]()
    
    public init() {}
    
    public func with(key: String, value: String) -> URLComponentsBuilder {
        queryItems.append(URLQueryItem(name: key, value: value))
        return self
    }
    
    public func build() -> URLComponents {
        
        var components = URLComponents()
        
        guard let configuration = configuration else {
            return components
        }
        
        components.scheme = configuration.scheme.rawValue
        components.host = configuration.host
        components.path = configuration.path
        
        queryItems.append(URLQueryItem(name: "api_key", value: configuration.key))
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        
        components.queryItems = queryItems
        
        return components
    }
}
