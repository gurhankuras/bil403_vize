//
//  Placeholder.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import Foundation
import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    let color: Color

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 15)
            }
            content
            .foregroundColor(color)
            .padding(5.0)
        }
    }
}
