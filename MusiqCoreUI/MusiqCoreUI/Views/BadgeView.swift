//
//  BadgeView.swift
//  MusiqCoreUI
//
//  Created by Olivier Rigault on 05/02/2021.
//

import SwiftUI

public struct BadgeView: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let horizontalInset: CGFloat = 8
        static let verticalInset: CGFloat = 4
        static let defaultTextColor = Color.white
    }
    
    var text: String
    var backgroundColor: Color
    var textColor: Color
    
    public init(text: String, backgroundColor: Color, textColor: Color? = nil) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor ?? Constants.defaultTextColor
    }

    public var body: some View {
        Text(text)
            .font(.caption)
            .padding(EdgeInsets(top: Constants.verticalInset,
                                leading: Constants.horizontalInset,
                                bottom: Constants.verticalInset,
                                trailing: Constants.horizontalInset))
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(backgroundColor))
            .foregroundColor(textColor)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(text: "String", backgroundColor: .purple)
    }
}
