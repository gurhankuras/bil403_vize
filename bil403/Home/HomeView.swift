//
//  HomeView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

/*
 
 
 ZStack {
     Spacer()
     Text("Gel de Getir")
         .fontWeight(.bold)
         .font(.title2)
         .padding(.vertical, 10)
         .foregroundColor(Color(.sRGB, red: 255 / 255, green: 255 / 255, blue: 66 / 255, opacity: 1))
         .frame(maxWidth: .infinity, alignment: .center)
     HStack {
         Spacer()
         CartIcon()
     }
     .padding(.trailing, 10)
     //Spacer()
 }
 .background(appPurple)
 */

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
                        .frame(maxWidth: .infinity, alignment: .center)
                        .overlay {
                            HStack {
                                Spacer()
                                CartIcon()
                                    .frame(maxHeight: 30)
                            }
                            .padding(.trailing, 10)
                        }
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


