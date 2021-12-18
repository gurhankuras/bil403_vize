//
//  SwiftUIView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryProductsView: View {
    let category: Category
    @StateObject var productsViewModel: ProductsViewModel
    
    
    init(category: Category, productService: ProductServiceProtocol) {
        self.category = category
         _productsViewModel = StateObject(wrappedValue:
                                            ProductsViewModel(category: category.id ,productService: Dependencies.instance.productService))
    }
    var body: some View {
            ScrollView {
                if (productsViewModel.loading) {
                    ProgressView()
                }
                else {
                    ProductsGrid(products: $productsViewModel.products)
                        .padding(.top, 10)
                }
            }
    }
}

struct CategoryProductsView_Previews: PreviewProvider {
    static let category = Category(id: ProdCategory.kisiselBakim, title: "Meyve & Sebze",image: "" )
    
    static let productService = MockProductService()
    
    static var previews: some View {
        CategoryProductsView(category: Self.category, productService: productService)
    }
}




struct ProductsGrid: View {
    @Binding var products: [Product]
    // let data = (1...10).map { "Item \($0)" }
    @State var presentedProduct: Product? = nil
    @State var presented: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(products) { item in
                Button {
                    presented = true
                    presentedProduct = item
                } label: {
                    ProductCard(product: item)
                }
            }
        }
        .sheet(isPresented: $presented) {
            ProductDetailsPage(product: $presentedProduct)
        }
        .padding(.horizontal)
    }
}


