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
    let symbolSize: CGFloat?
    let message: String?
    let font: Font?

    var body: some View {
        VStack {
            if let symbol = symbol,
               let symbolSize = symbolSize {
                Image(systemName: symbol)
                    .font(.system(size: symbolSize))
                    .padding()
            }
            if let message = message,
               let font = font {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(font)
            }
        }
        .padding()
    }
}

public class ErrorViewBuilder: BuilderProtocol {
    
    private var symbol: String?
    private var symbolSize: CGFloat = 56
    private var message: String?
    private var font = Font.body
    
    public init() {}
    
    public func withSymbol(_ symbol: String) -> ErrorViewBuilder {
        self.symbol = symbol
        return self
    }
    
    public func withSymbolSize(_ symbolSize: CGFloat) -> ErrorViewBuilder {
        self.symbolSize = symbolSize
        return self
    }

    public func withMessage(_ message: String) -> ErrorViewBuilder {
        self.message = message
        return self
    }
    
    public func withFont(_ font: Font) -> ErrorViewBuilder {
        self.font = font
        return self
    }
    
    public func build() -> some View {
        ErrorView(symbol: symbol, symbolSize: symbolSize, message: message, font: font)
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
                .previewDisplayName("Message only")
            ErrorViewBuilder()
                .withSymbol(Constants.symbol)
                .build()
                .previewDisplayName("Symbol only")
            ErrorViewBuilder()
                .withSymbol(Constants.symbol)
                .withSymbolSize(80)
                .withMessage(Constants.message)
                .withFont(.headline)
                .build()
                .previewDisplayName("Full error view")
        }
    }
}
