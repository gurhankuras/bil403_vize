//
//  SwiftUIView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct CategoryProductsView: View {
    let category: Category
    let productService: ProductServiceProtocol
    @StateObject var productsViewModel: ProductsViewModel
    
    
    init(category: Category, productService: ProductServiceProtocol) {
        self.category = category
        self.productService = productService
         _productsViewModel = StateObject(wrappedValue:
                                          ProductsViewModel(categoryId: category.id ,productService: productService))
    }
    var body: some View {
        /*
        GeometryReader { geometry in
                    ScrollView(.vertical) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 0.01)
                        ForEach($productsViewModel.products) { o in
                            Text("\(o.id)")
                        }
                    }
                }
         */
        
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
    static let category = Category(id: ProductCategories.kisiselBakim.rawValue, title: "Meyve & Sebze",image: "" )
    
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


