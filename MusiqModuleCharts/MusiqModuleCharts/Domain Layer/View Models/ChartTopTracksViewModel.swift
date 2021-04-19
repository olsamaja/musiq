//
//  ChartTopTracksViewModel.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Combine
import MusiqCore
import MusiqNetwork

public final class ChartTopTracksViewModel: ObservableObject {
    
}

public extension ChartTopTracksViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([ChartTopTrackRowItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ChartTopTrackRowItem])
        case onFailedToLoadData(Error)
    }
}
