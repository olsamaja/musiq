//
//  SearchBar.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 05/01/2021.
//
// Source: https://www.appcoda.com/swiftui-search-bar/
//

import Foundation
import SwiftUI
import Combine

public struct SearchBar: View {

    let placeholder: String
    @Binding var text: String
    @State private var isEditing = false
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let containerPadding: CGFloat = 7.0
        static let padding: CGFloat = 8.0
        static let backgroundColor = Color(.systemGray6)
    }
    
    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(Constants.containerPadding)
                .padding(.horizontal, Constants.padding)
                .background(Constants.backgroundColor)
                .cornerRadius(Constants.cornerRadius)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    self.hideKeyboard()

                }) {
                    Text("Cancel")
                }
                .padding(.trailing, Constants.padding)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .onReceive(Publishers.isKeyboardShown) {
            // Hides the Cancel button when the keyboard disappears,
            // even when tapping on background view only,
            // instead of tapping on Cancel button
            self.isEditing = $0
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeholder: "Search", text: .constant(""))
    }
}
