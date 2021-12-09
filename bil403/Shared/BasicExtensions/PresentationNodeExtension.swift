//
//  PresentationNodeExtension.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import Foundation
import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func open() {
        self = true
        print("OPEN WORKED")
        print(self)
    }
    
    public mutating func close() {
        self = false
        print("CLOSE WORKED")
        print(self)
    }
}
