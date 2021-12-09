//
//  ColorExtension.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation
import SwiftUI

let appPurple = Color("appPurple")

let lightAppPurple = Color("lightAppPurple")
let offWhite = Color("offWhite")


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
