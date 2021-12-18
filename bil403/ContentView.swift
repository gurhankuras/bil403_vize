//
//  ContentView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cart = Cart()
    
    var body: some View {
       
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                SearchProductPage()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                //Text("User Tab")
                  UserProfilePage()
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

