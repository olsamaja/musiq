//
//  Feedback.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 23/01/2021.
//

import Foundation
import Combine

public struct Feedback<State, Event> {
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

public extension Feedback {
    init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
        self.run = { state -> AnyPublisher<Event, Never> in
            state
                .map { effects($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        }
    }
}
