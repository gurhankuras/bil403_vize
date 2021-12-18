//
//  CategoryCard.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category
    let categories: [Category]
    
    var body: some View {
    
        NavigationLink {
            ProductsView(category: category, categories: categories)
        } label: {
            VStack {
                AsyncImage(url: URL(string: category.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                Text(category.title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }.foregroundColor(appPurple)
        }
        .tint(appPurple)
    }
}
