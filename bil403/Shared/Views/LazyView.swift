//
//  LazyView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct LazyView<T: View>: View {
    var view: () -> T

    init(view: @escaping () -> T) {
        self.view = view
    }
    
    var body: some View {
        self.view()
    }
}
