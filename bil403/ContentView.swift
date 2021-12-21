//
//  ContentView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cart = Cart(productService: Dependencies.instance.productService)
    
    var body: some View {
       
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                LazyView {
                    SearchProductPage()
                }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                LazyView {
                    UserProfilePage()
                }
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
            .shadow(radius: 2)
            .accentColor(appPurple)
            .environmentObject(cart)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

