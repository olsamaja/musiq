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
        case loaded([ListItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ListItem])
        case onFailedToLoadData(Error)
        case onPerform(Action)
    }
    
    enum Action {
        case search(String)
        case select(Artist)
        case clear
    }
}

extension ArtistsViewModel.State: Equatable {
    public static func == (lhs: ArtistsViewModel.State, rhs: ArtistsViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (let .searching(string1), let .searching(string2)):
            return string1 == string2
        case (.loaded, .loaded):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension ArtistsViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .searching(let term):
            return reduceSearching(state, event, searchTerm: term)
        case .loaded(let items):
            return reduceLoaded(state, event, items: items)
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
    
    static func reduceSearching(_ state: State, _ event: Event, searchTerm: String) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onDataLoaded(let artists):
            return .loaded(artists)
        default:
            return state
        }
    }

    static func reduceLoaded(_ state: State, _ event: Event, items: [ListItem]) -> State {
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
