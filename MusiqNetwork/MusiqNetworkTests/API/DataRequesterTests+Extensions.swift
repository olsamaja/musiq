//
//  DataRequesterTests+Extensions.swift
//  MusiqNetworkTests
//
//  Created by Olivier Rigault on 25/05/2021.
//

import Foundation
import Combine
import Resolver
@testable import MusiqNetwork
@testable import MusiqCore

struct DataRequesterTestDTO: Decodable {
    let message: String
}

extension DataRequester {
    
    func loadTestData() -> AnyPublisher<DataRequesterTestDTO, DataError> {
        return loadData(with: URLComponents())
    }
    
    func loadTestDataWithInvalidComponents() -> AnyPublisher<DataRequesterTestDTO, DataError> {
        
        // Build URLComponents with an invalid url
        // https://stackoverflow.com/questions/39852659/urlcomponents-url-is-nil
        var urlComponents = URLComponents(string: "http://google.com")!
        urlComponents.path = "auth/login"

        return loadData(with: urlComponents)
    }
}
