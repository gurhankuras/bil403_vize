//
//  ProductsViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation
import Combine

final class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var loading: Bool = false

  
    let category: ProdCategory
    let productService: ProductServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(category: ProdCategory, productService: ProductServiceProtocol) {
        self.category = category
        self.productService = productService
        loadProducts()
    }
    
    deinit {
        print("\(Self.self) DEINIT")
    }
    
    func loadProducts() {
        loading = true
    
        productService.fetch(by: category)
            .sink { [weak self] (_) in
                /*
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
                */
                 self?.loading = false
    
            } receiveValue: {[weak self] prods in
                self?.products = prods
            }
            .store(in: &cancellables)
    }
}
