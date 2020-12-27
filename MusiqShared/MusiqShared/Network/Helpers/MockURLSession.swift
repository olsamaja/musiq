//
//  MockURLSession.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 28/12/2020.
//

import Foundation

extension URLSession {
    
    static func makeMockURLSession(_ protocolClasses: [AnyClass]? = [MockURLProtocol.self]) -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = protocolClasses
        return URLSession(configuration: configuration)
    }
    
}
