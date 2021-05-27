//
//  ChartTopArtistsViewModel+Reduce.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 27/05/2021.
//

import Foundation
import Combine
import MusiqCore
import MusiqNetwork

public extension ChartTopArtistsViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([ChartTopArtistRowItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ChartTopArtistRowItem])
        case onFailedToLoadData(Error)
    }
}

extension ChartTopArtistsViewModel.State: Equatable {
    public static func == (lhs: ChartTopArtistsViewModel.State, rhs: ChartTopArtistsViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.loaded, .loaded),
             (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension ChartTopArtistsViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .loading:
            return reduceLoading(state, event)
        case .loaded:
            return reduceLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onAppear:
            return .loading
        default:
            return state
        }
    }
    
    static func reduceLoading(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onDataLoaded(let artists):
            return .loaded(artists)
        default:
            return state
        }
    }

    static func reduceLoaded(_ state: State, _ event: Event) -> State {
        return state
    }
    
    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}

extension ChartTopArtistsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
