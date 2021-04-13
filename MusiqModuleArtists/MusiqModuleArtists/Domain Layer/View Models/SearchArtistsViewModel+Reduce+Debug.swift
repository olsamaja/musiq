//
//  SearchArtistsViewModel+Reduce+Debug.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 25/03/2021.
//

import Foundation

public extension SearchArtistsViewModel.State {
    
    var debugDescription: String {
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

public extension SearchArtistsViewModel.Event {
    
    var debugDescription: String {
        switch self {
        case .onAppear:
            return "Event.onAppear"
        case .onDataLoaded(let items):
            return "Event.onDataLoaded(\(items.count))"
        case .onFailedToLoadData(_):
            return "Event.error"
        case .onPerform(let action):
            return "Event.onPerform(\(action.debugDescription))"
        }
    }
}

public extension SearchArtistsViewModel.UserAction {
    
    var debugDescription: String {
        switch self {
        case .search(let term):
            return "Action.search(\(term))"
        case .select(let artist):
            return "Action.select(\(artist.name))"
        case .clear:
            return "Action.clear"
        }
    }
}
