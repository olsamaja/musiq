//
//  ChartTopTagRowItem.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 01/06/2021.
//

import Foundation

public struct ChartTopTagRowItem: Identifiable {
    
    public let id: String
    let name: String
    let taggings: String

    init(tag: ChartTopTag) {
        self.id = UUID().uuidString
        self.name = tag.name
        self.taggings = tag.taggings
    }
    
    init(name: String, taggings: String) {
        self.id = UUID().uuidString
        self.name = name
        self.taggings = taggings
    }
}

extension ChartTopTagRowItem: Equatable {}
