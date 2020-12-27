//
//  ConfigurationDTOMapperTests.swift
//  MusiqConfigurationTests
//
//  Created by Olivier Rigault on 26/12/2020.
//

import XCTest
@testable import MusiqConfiguration

class ConfigurationDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let scheme = "https"
        let host = "www.thisisahost.com"
        let path = "/thisisapath/"
        let key = "thisisakey"
        
        let dto = ConfigurationDTO(scheme: scheme, host: host, path: path, key: key)
        do {
            let configuration = try ConfigurationDTOMapper.map(dto)
            XCTAssertEqual(configuration.scheme, Configuration.Scheme.https)
            XCTAssertEqual(configuration.host, host)
            XCTAssertEqual(configuration.path, path)
            XCTAssertEqual(configuration.key, key)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testValidScheme() throws {
        
        let dto1 = ConfigurationDTO(scheme: "http", host: "host", path: "path", key: "key")
        try checkValidScheme(dto: dto1)
        
        let dto2 = ConfigurationDTO(scheme: "https", host: "host", path: "path", key: "key")
        try checkValidScheme(dto: dto2)
    }

    func testInvalidScheme() throws {
        
        let dto = ConfigurationDTO(scheme: "thisisnotascheme", host: "host", path: "path", key: "key")
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
            XCTFail("Expected scheme property to be invalid")
        } catch ConfigurationDTOMapper.ValidationError.invalid(let property){
            XCTAssertEqual(property, .scheme)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testMissingProperties() throws {
        
        let dto1 = ConfigurationDTO(scheme: nil, host: "host", path: "path", key: "key")
        try checkMissingProperty(dto: dto1, with: ConfigurationDTOMapper.ValidationError.empty(.scheme))
        
        let dto2 = ConfigurationDTO(scheme: "https", host: nil, path: "path", key: "key")
        try checkMissingProperty(dto: dto2, with: ConfigurationDTOMapper.ValidationError.empty(.host))
        
        let dto3 = ConfigurationDTO(scheme: "http", host: "host", path: nil, key: "key")
        try checkMissingProperty(dto: dto3, with: ConfigurationDTOMapper.ValidationError.empty(.path))
        
        let dto4 = ConfigurationDTO(scheme: "https", host: "host", path: "path", key: nil)
        try checkMissingProperty(dto: dto4, with: ConfigurationDTOMapper.ValidationError.empty(.key))
    }

    // MARK: - Helpers

    private func checkValidScheme(dto: ConfigurationDTO) throws {
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    private func checkMissingProperty(dto: ConfigurationDTO, with validationError: ConfigurationDTOMapper.ValidationError) throws {
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
            XCTFail("Expected property to be missing")
        } catch ConfigurationDTOMapper.ValidationError.empty(let property) {
            XCTAssertEqual(validationError, ConfigurationDTOMapper.ValidationError.empty(property))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

// MARK: - ConfigurationDTOMapper.ValidationError : Equatable

extension ConfigurationDTOMapper.ValidationError : Equatable {

    public static func ==(lhs: ConfigurationDTOMapper.ValidationError, rhs: ConfigurationDTOMapper.ValidationError) -> Bool {
        switch (lhs, rhs) {
        case (.empty(let lhsProperty), .empty(let rhsProperty)):
            return lhsProperty == rhsProperty
        case (.invalid(let lhsProperty), .invalid(let rhsProperty)):
            return lhsProperty == rhsProperty
        default:
            return false
        }
    }
}
