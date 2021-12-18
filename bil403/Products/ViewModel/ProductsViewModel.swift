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
    
    
    func loadProducts() {
        guard let request = Endpoint.products(by: category).url else {
            return
        }
        
       // print(ApiURL.products(by: category))
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: [Product].self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
                self?.loading = false
    
            } receiveValue: {[weak self] prods in
                self?.products = prods
            }
            .store(in: &cancellables)
        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
}
