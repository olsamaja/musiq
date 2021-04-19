//
//  ChartTopTracksViewModel+Reduce.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation
import Combine
import MusiqCore
import MusiqNetwork

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

extension ChartTopTracksViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        OLLogger.info("\(state.debugDescription)")
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
        case .onDataLoaded(let tracks):
            return .loaded(tracks)
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

extension ChartTopTracksViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
