//
//  ScreenPreview.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 02/04/2021.
//

import SwiftUI

public struct ScreenPreview: ViewModifier {
    
    enum Constants {
        static let width: CGFloat = 375
        static let height: CGFloat = 375
    }
    
    let title: String
    
    public func body(content: Content) -> some View {
        content
            .previewLayout(PreviewLayout.fixed(width: Constants.width, height: Constants.height))
            .previewDisplayName(title)
    }
}

extension View {
    func screenPreview(with title: String) -> some View {
        self.modifier(ScreenPreview(title: title))
    }
}
