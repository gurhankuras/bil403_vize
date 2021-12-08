//
//  SearchProductPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct SearchProductPage: View {


    @State var searchText: String = ""
    //@FocusState private var searchFieldFocused = true

    init() {
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Arama")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, 5)
            .background(appPurple)
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(appPurple)
                    .scaleEffect(1.0)
                TextField(
                    "Ürün Ara",
                    text: $searchText
                )
                    //.focused($searchFieldFocused)
                    .font(.subheadline)
                    .onSubmit {
                        
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical)
                    .padding(.leading, 7)
                  
                 
            }
            .frame(maxWidth: .infinity)
            
            .padding(.horizontal)
            //.background()
            //.clipShape(RoundedRectangle(cornerRadius: 10))
            //.shadow(radius: 2, x: 0, y: 3)
            .background(Color.white)
            .cornerRadius(2.0)
            .shadow(radius: 3)
               
            Spacer()
        }
    }
}

struct SearchProductPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductPage()
    }
}
