//
//  CategoryCard.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryCard: View {
    let url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Culinary_fruits_front_view.jpg/640px-Culinary_fruits_front_view.jpg"
    
    var body: some View {
    
        NavigationLink {
            ProductsView()
        } label: {
            VStack {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                Text("Meyve")
                    .font(.subheadline)
            }.foregroundColor(.purple)
        }
        .tint(.purple)

        
       // .background(.blue)
        
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard()
    }
}
