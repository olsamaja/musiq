//
//  ArtistsViewModel+Reduce.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 06/02/2021.
//

import Foundation
import Combine
import MusiqCore
import MusiqShared

public extension ArtistsViewModel {
    
    enum State {
        case idle
        case searching(String)
        case loaded([ArtistCardItem])
        case error(Error)
        
        var debugString: String {
            switch self {
            case .idle:
                return "State.idle"
            case .searching(let searchText):
                return "State.searching(\(searchText))"
            case .loaded(let items):
                return "State.loaded(\(items.count))"
            case .error(_):
                return "State.error"
            }
        }
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ArtistCardItem])
        case onFailedToLoadData(Error)
        case onPerform(Action)
        
        var debugString: String {
            switch self {
            case .onAppear:
                return "Event.onAppear"
            case .onDataLoaded(let items):
                return "Event.onDataLoaded(\(items.count))"
            case .onFailedToLoadData(_):
                return "Event.error"
            case .onPerform(let action):
                return "Event.onPerform(\(action.debugString)"
            }
        }
    }
    
    enum Action {
        case search(String)
        case select(Artist)
        case clear
        
        var debugString: String {
            switch self {
            case .search(let term):
                return "Action.search(\(term))"
            case .select(let artist):
                return "Action.select(\(artist.name)"
            case .clear:
                return "Action.clear"
            }
        }
    }
}

extension ArtistsViewModel.State: Equatable {
    public static func == (lhs: ArtistsViewModel.State, rhs: ArtistsViewModel.State) -> Bool {
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

extension ArtistsViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        OLLogger.info("****** State: \(state.debugString)")
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

extension ArtistsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
