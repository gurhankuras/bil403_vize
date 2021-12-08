//
//  SwiftUIView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryProductsView: View {
    var body: some View {
        ScrollView {
            ProductsGrid()
        }
        
    }
}

struct CategoryProductsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryProductsView()
    }
}




struct ProductsGrid: View {
    let data = (1...10).map { "Item \($0)" }
    let productMock = mockProduct
    @State var presented: Bool = false
    
        let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(data, id: \.self) { item in
                Button {
                    presented = true
                } label: {
                    ProductCard(product: productMock)
                }

            }
        }
        .sheet(isPresented: $presented) {
            ProductDetailsPage(product: productMock)
        }
        .padding(.horizontal)
    }
}


