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
    @Published var loading: Bool = false

    let categoryId: String
    let productService: ProductServiceProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    init(categoryId: String, productService: ProductServiceProtocol) {
        self.categoryId = categoryId
        self.productService = productService
        loadProducts()
    }
    
    /*
    func loadProducts() {
        loading = true
        productService.getProductsBy(category: categoryId)
            .sink { [weak self] completion  in
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
                self?.loading = false
            } receiveValue: { [weak self] returnedPosts in
                print(returnedPosts)
                self?.products = returnedPosts
            }
            .store(in: &cancellables)

    }
     */
    
    func loadProducts() {
        guard let request = makeGetRequest(urlStr: ApiURL.products(by: categoryId)) else {
            return
        }
        
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
    

    private func makeGetRequest(urlStr: String) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        /*
        guard let parameters = processInputs() else {
            return nil
        }
         */
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request
        return request
    }
}
