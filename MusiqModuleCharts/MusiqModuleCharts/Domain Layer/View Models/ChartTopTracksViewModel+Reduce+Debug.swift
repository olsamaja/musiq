//
//  ChartTopTracksViewModel+Reduce+Debug.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation

public extension ChartTopTracksViewModel.State {
    
    var debugDescription: String {
        switch self {
        case .idle:
            return "State.idle"
        case .loading:
            return "State.loading"
        case .loaded(let items):
            return "State.loaded(\(items.count))"
        case .error(_):
            return "State.error"
        }
    }
}

public extension ChartTopTracksViewModel.Event {
    
    var debugDescription: String {
        switch self {
        case .onAppear:
            return "Event.onAppear"
        case .onDataLoaded(let items):
            return "Event.onDataLoaded(\(items.count))"
        case .onFailedToLoadData(_):
            return "Event.error"
        }
    }
}
