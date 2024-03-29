//
//  SearchArtistsViewModel.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 05/01/2021.
//

import Combine
import MusiqCore
import MusiqNetwork

public final class SearchArtistsViewModel: ObservableObject {
    
    @Published var state = State.idle
    @Published var searchTerm = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()
    
    public init(state: State = .idle) {
        setupFeedbacks()
        setupBindings()
        self.state = state
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
        
        let searchPublisher = $searchTerm
                .dropFirst(1)
                .debounce(for: 1, scheduler: RunLoop.main)
                .removeDuplicates()
        
        searchPublisher
            .filter { $0.count > 2 }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (term) in
                self?.send(event: .onPerform(.search(term)))
            })
        .store(in: &cancellables)
        
        searchPublisher
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
    
    func search(with searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    func clear() {
        send(event: .onPerform(.clear))
    }
    
    static func whenSearching() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .searching(let term) = state else { return Empty().eraseToAnyPublisher() }
            
            return ArtistDataManager().search(with: term)
                .map { $0.map(ArtistRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}
