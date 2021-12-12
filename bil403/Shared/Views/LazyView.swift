//
//  LazyView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct LazyView<T: View>: View {
    init(view: @escaping () -> T) {
        self.view = view
        // print("LazyView initiliazed!")
    }
    
    var view: () -> T
    var body: some View {
        self.view()
    }
}

/*
struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView()
    }
}
*/
