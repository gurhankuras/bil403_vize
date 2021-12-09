//
//  NavigationHelper.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import Foundation

class NavigationHelper: ObservableObject {
    @Published var route: String? = nil
    
    func close() {
        print("close called")
        route = nil
        print(route ?? "nil")
    }
    
    func open(route: String) {
        print("open called")
        self.route = route
        print("route: \(route)")
    }
}


enum NavigationRoutes: String {
    case addressPaymentSelection = "addressPaymentSelection"
}
