//
//  BackgroundContentView.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 09/01/2021.
//

import SwiftUI

public struct Background<Content: View>: View {
    
    private var content: Content
    private let backgroundColor: Color?

    public init(backgroundColor: Color? = .white, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack {
            AnyView(backgroundColor)
            content
        }
    }
}
