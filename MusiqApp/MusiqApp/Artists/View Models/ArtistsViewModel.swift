//
//  ArtistsViewModel.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 05/01/2021.
//

import Foundation
import Combine
import MusiqCore
import MusiqShared

final class ArtistsViewModel: ObservableObject {
    
    @Published private(set) var state = State.idle
    @Published var searchTerm = ""

    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()
    
    init() {
        setupFeedbacks()
        setupBindings()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    private func setupFeedbacks() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenSearching(),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
        $searchTerm
            .dropFirst(1)
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count > 2 }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (term) in
                self?.send(event: .onPerform(.search(term)))
            })
        .store(in: &cancellables)

        $searchTerm
            .dropFirst(1)
            .removeDuplicates()
            .filter { $0.count == 0 }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (_) in
                self?.send(event: .onPerform(.clear))
            })
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenSearching() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .searching(let term) = state else { return Empty().eraseToAnyPublisher() }
            
            return ArtistDataManager().search(with: term)
                .map { $0.map(ListItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension ArtistsViewModel {
    
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

extension ArtistsViewModel {
    
    static func reduce(_ state: State, _ event: Event) -> State {
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

extension ArtistsViewModel: Identifiable {
    
    struct ListItem: Identifiable {
        let id: UUID
        let name: String
        let listeners: String?
        
        init(artist: Artist) {
            self.id = UUID()
            self.name = artist.name
            self.listeners = artist.listeners
            OLLogger.info("name: \(name)")
        }
    }
}
