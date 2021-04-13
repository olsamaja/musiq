//
//  SearchArtistsViewModel+Reduce.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 06/02/2021.
//

import Foundation
import Combine
import MusiqCore
import MusiqNetwork

public extension SearchArtistsViewModel {
    
    enum State {
        case idle
        case searching(String)
        case loaded([ArtistRowItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ArtistRowItem])
        case onFailedToLoadData(Error)
        case onPerform(UserAction)
    }
    
    enum UserAction {
        case search(String)
        case select(Artist)
        case clear
    }
}

extension SearchArtistsViewModel.State: Equatable {
    public static func == (lhs: SearchArtistsViewModel.State, rhs: SearchArtistsViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loaded, .loaded),
             (.error, .error):
            return true
        case (let .searching(string1), let .searching(string2)):
            return string1 == string2
        default:
            return false
        }
    }
}

extension SearchArtistsViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        OLLogger.info("\(state.debugDescription)")
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .searching:
            return reduceSearching(state, event)
        case .loaded:
            return reduceLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onPerform(.search(let term)):
            return .searching(term)
        default:
            return state
        }
    }
    
    static func reduceSearching(_ state: State, _ event: Event) -> State {
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
        switch event {
        case .onPerform(.search(let term)):
            return .searching(term)
        case .onPerform(.clear):
            return .idle
        default:
            return state
        }
    }
    
    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}

extension SearchArtistsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
