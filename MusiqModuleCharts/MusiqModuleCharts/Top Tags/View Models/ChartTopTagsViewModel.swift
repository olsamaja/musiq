//
//  ChartTopTagsViewModel.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 01/06/2021.
//

import Combine
import MusiqCore
import MusiqNetwork

public final class ChartTopTagsViewModel: ObservableObject {

    @Published var state = State.idle
    
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
                Self.whenLoading(),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoading() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }

            return ChartsDataManager().getTopTags()
                .map { $0.map(ChartTopTagRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }

}
