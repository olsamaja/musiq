//
//  ModuleChartsServices+Injection.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 15/05/2021.
//

import MusiqCore
import Resolver

public extension Resolver {
    
    static func registerModuleChartsServices() {
        register { ChartTopTracksViewModel() as ChartTopTracksViewModel }
        register { ChartTopArtistsViewModel() as ChartTopArtistsViewModel }
    }
}
