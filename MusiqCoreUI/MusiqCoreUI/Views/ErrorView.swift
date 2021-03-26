//
//  ErrorView.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 26/03/2021.
//

import SwiftUI

struct ErrorView: View {

    let message: String?
    let symbol: String?

    var body: some View {
        VStack {
            if let symbol = symbol {
                Image(systemName: symbol)
                    .font(.system(size: 56.0))
                    .padding()
            }
            if let message = message {
                Text(message)
            }
        }
    }
}

public class ErrorViewBuilder {
    
    private var message: String?
    private var symbol: String?
    
    public init() {}
    
    public func withMessage(_ message: String) -> ErrorViewBuilder {
        self.message = message
        return self
    }
    
    public func withSymbol(_ symbol: String) -> ErrorViewBuilder {
        self.symbol = symbol
        return self
    }

    @ViewBuilder
    public func build() -> some View {
        ErrorView(message: message, symbol: symbol)
    }
}
