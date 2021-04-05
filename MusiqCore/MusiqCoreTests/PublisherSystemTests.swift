//
//  PublisherSystemTests.swift
//  MusiqCoreTests
//
//  Created by Olivier Rigault on 04/04/2021.
//

import XCTest
import Combine
@testable import MusiqCore

class PublisherSystemTests: XCTestCase {
    
    enum State {
        case idle
        case loading
        case loaded
        case error
    }
    
    enum Event {
        case doSomething
        case triggerError
    }

    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return .loading
        case .loading:
            switch event {
            case .triggerError:
                return .error
            default:
                return .loaded
            }
         case .loaded:
            return .loaded
        case .error:
            return .error
        }
    }

    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        cancellable?.cancel()
    }
    
    func testIdle() throws {
        
        let expectation = XCTestExpectation(description: "Reducing idle")
        let action = PassthroughSubject<Event, Never>()

        cancellable = Publishers.system(
            initial: .idle,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .dropFirst()    // Drop initial state
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in })
        { state in
            XCTAssertEqual(state, .loading)
            expectation.fulfill()
        }
        
        action.send(Event.doSomething)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadingWithFeedback() throws {
        
        let expectation = XCTestExpectation(description: "Reducing loading with feedback")
        let action = PassthroughSubject<Event, Never>()

        cancellable = Publishers.system(
            initial: .loading,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .dropFirst()    // Drop initial state
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in })
        { state in
            XCTAssertEqual(state, .error)
            expectation.fulfill()
        }
        
        action.send(Event.triggerError)
        
        wait(for: [expectation], timeout: 1)
    }

    private static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
    
    static func whenLoading() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return Just(Event.triggerError)
                .eraseToAnyPublisher()
        }
    }
}
