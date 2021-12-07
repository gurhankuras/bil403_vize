//
//  HomeView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI



struct HomeView: View {
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Group {
                        Text("Gel de Getir")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding()
                            .foregroundColor(Color(.sRGB, red: 255 / 255, green: 255 / 255, blue: 66 / 255, opacity: 1))
                    }
                    Spacer()
                }
                .background(.purple)
                .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                ScrollView {
                    AdvertisementCarouselView()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                    CategoriesGrid()
                }
                
            }
        
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



