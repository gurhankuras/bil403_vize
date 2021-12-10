//
//  SwiftUIView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryProductsView: View {
    let category: ProductCategory
    let productService: ProductServiceProtocol
    @StateObject var productsViewModel: ProductsViewModel
    
    
    init(category: ProductCategory, productService: ProductServiceProtocol) {
        self.category = category
        self.productService = productService
         _productsViewModel = StateObject(wrappedValue:
                                          ProductsViewModel(categoryId: category.id ,productService: productService))
    }
    var body: some View {
        ScrollView {
            
            ProductsGrid(products: $productsViewModel.products)
                .padding(.top, 10)
        }
        
    }
}

struct CategoryProductsView_Previews: PreviewProvider {
    static let category = ProductCategory(name: "Meyve & Sebze", id: ProductCategories.kisiselBakim.rawValue)
    
    static let productService = MockProductService()
    
    static var previews: some View {
        CategoryProductsView(category: Self.category, productService: productService)
    }
}




struct ProductsGrid: View {
    @Binding var products: [Product]
    // let data = (1...10).map { "Item \($0)" }
   let productMock = mockProduct
    @State var presented: Bool = false
    
        let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(products) { item in
                Button {
                    presented = true
                } label: {
                    ProductCard(product: item)
                }
            }
        }
        .sheet(isPresented: $presented) {
            ProductDetailsPage(product: productMock)
        }
        .padding(.horizontal)
    }
}


