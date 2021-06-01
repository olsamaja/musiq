//
//  ChartTopTagsViewModel+Reduce.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 01/06/2021.
//

import Combine
import MusiqCore
import MusiqNetwork

public extension ChartTopTagsViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([ChartTopTagRowItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ChartTopTagRowItem])
        case onFailedToLoadData(Error)
    }
}

extension ChartTopTagsViewModel.State: Equatable {
    public static func == (lhs: ChartTopTagsViewModel.State, rhs: ChartTopTagsViewModel.State) -> Bool {
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

extension ChartTopTagsViewModel {
    
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
        case .onDataLoaded(let tags):
            return .loaded(tags)
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

extension ChartTopTagsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
