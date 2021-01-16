//
//  Keyboard+Extensions.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 09/01/2021.
//

import SwiftUI
import Combine

public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public extension Publishers {
    
    static var isKeyboardShown: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in true }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in false }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
