//
//  ProductServiceProtocol.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/20/21.
//

import Foundation
import Combine


final class ProductService: ProductServiceProtocol {
    
    struct MalformedURLError: Error {}
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        print("ProductService Initiliazed")
    }
    
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        guard let url = networkService.makeRequest(to: Endpoint.stock(for: productId), with: productId, method: .delete)  else {
            print("URL is malformed")
            return Fail(error: MalformedURLError())
                .eraseToAnyPublisher()
        }
       return networkService
            .publisher(for: url, responseType: ApiMessage.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetch(by category: ProdCategory) -> AnyPublisher<[Product], Error> {
        guard let url = Endpoint.products(by: category).url else {
            return Fail(error: MalformedURLError())
                .eraseToAnyPublisher()
        }
        
        return networkService.publisher(for: url, responseType: [Product].self, decoder: .init())
    }
   
    
    
   
    
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        guard let url = Endpoint.search(matching: query, sortedBy: .recency).url else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return networkService.publisher(for: url, responseType: [Product].self, decoder: .init())
    }
     
    /*
    func getProductsBy(category: String) -> AnyPublisher<[Product], Error> {
        guard let request = makeRequest(for: "sadasdasd") else {
            return Just([Product]())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
                    .map({ $0.data })
                    .decode(type: [Product].self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
    }
     */
        
}


/*
final class MockProductService: ProductServiceProtocol {
    private let defaultProducts
    = [
        Product(id: 1, name: "Elma",  image: "",cost: 4.5, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: 45, name: "Domates",  image: "",cost: 7.55, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: 56, name: "Biber",  image: "",cost: 9.50, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: 13, name: "Armut",  image: "",cost: 10.45, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: 75, name: "Havuç", image: "", cost: 8.5, additionalInfo: "1 kg", category: "meyve&sebze"),
        
        Product(id: 97, name: "Colgate Diş Fırçası", image: "", cost: 20.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: 9, name: "Duru Şampuan",  image: "",cost: 28.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: 7, name: "Sendodyne Diş Macunu",  image: "",cost: 25.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: 97, name: "Deodorant",  image: "",cost: 4.5, additionalInfo: "", category: "kisiselbakim"),
      ]
    
    private let products: [Product]
    private let fails: Bool
    
    init(fails: Bool = false, data: [Product]? = nil) {
        self.products = data ?? defaultProducts
        self.fails = fails
    }
    
    func getProductsBy(category: String) -> AnyPublisher<[Product], Error> {
        if fails {
            print("FAIL OLDU")
            return Just([])
                .tryMap({ publishedProducts in
                    throw URLError(.badServerResponse)
                    })
                .eraseToAnyPublisher()
        }
        let filteredProducts = products.filter { $0.category == category}
        return Just(filteredProducts)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    
}

*/
