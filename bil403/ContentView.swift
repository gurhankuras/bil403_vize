//
//  ContentView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        print("ContentView")
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        //NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                SearchProductPage()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("User Tab")
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            
            }
            .shadow(radius: 2)
            
        //}
        .accentColor(appPurple)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

