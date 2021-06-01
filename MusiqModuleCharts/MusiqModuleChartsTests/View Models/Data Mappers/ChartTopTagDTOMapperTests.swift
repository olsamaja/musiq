//
//  ChartTopTagDTOMapperTests.swift
//  MusiqModuleChartsTests
//
//  Created by Olivier Rigault on 04/06/2021.
//

import XCTest
@testable import MusiqModuleCharts

class ChartTopTagDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let name = "rock"
        let taggings = "1234"
        
        let dto = ChartTopTagDTO(name: name, taggings: taggings)
        let tag = ChartTopTagDTOMapper.map(dto)

        XCTAssertEqual(tag.name, name)
        XCTAssertEqual(tag.taggings, taggings)
    }

}
