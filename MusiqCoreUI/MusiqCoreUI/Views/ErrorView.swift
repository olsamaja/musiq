//
//  ErrorView.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 26/03/2021.
//

import SwiftUI
import MusiqCore

struct ErrorView: View {

    let symbol: String?
    let message: String?

    var body: some View {
        VStack {
            if let symbol = symbol {
                Image(systemName: symbol)
                    .font(.system(size: 56.0))
                    .padding()
            }
            if let message = message {
                Text(message)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

public class ErrorViewBuilder: BuilderProtocol {
    
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

    public func build() -> some View {
        ErrorView(symbol: symbol, message: message)
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum Constants {
        static let symbol = "xmark.octagon"
        static let message = """
        This is a pointless, useless and very
        long explanatioon for an error,
        that we just use for testing this view
        """
    }
    
    static var previews: some View {
        Group {
            ErrorViewBuilder()
                .withMessage(Constants.message)
                .build()
                .screenPreview(with: "Message only")
            ErrorViewBuilder()
                .withSymbol(Constants.symbol)
                .build()
                .screenPreview(with: "Symbol only")
            ErrorViewBuilder()
                .withSymbol(Constants.symbol)
                .withMessage(Constants.message)
                .build()
                .screenPreview(with: "Full error view")
        }
    }
}
