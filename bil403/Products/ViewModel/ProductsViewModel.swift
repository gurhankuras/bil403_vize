//
//  ProductsViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation
import Combine

class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    
    let categoryId: String
    let productService: ProductServiceProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    init(categoryId: String, productService: ProductServiceProtocol) {
        self.categoryId = categoryId
        self.productService = productService
        loadProducts()
    }
    
    func loadProducts() {
        productService.getProductsBy(category: categoryId)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.products = returnedPosts
            }
            .store(in: &cancellables)

    }
    
    
}
