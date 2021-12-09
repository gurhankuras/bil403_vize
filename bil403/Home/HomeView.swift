//
//  HomeView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI



struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Gel de Getir")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(.sRGB, red: 255 / 255, green: 255 / 255, blue: 66 / 255, opacity: 1))
                    Spacer()
                }
                .background(appPurple)
               
                ScrollView {
                    AdvertisementCarouselView()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                    CategoriesGrid()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


