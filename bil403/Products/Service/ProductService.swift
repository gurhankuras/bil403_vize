//
//  ProductService.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation
import Combine

protocol ProductServiceProtocol {
    func getProductsBy(category: String) -> AnyPublisher<[Product], Error>
}


class ProductService: ProductServiceProtocol {
    //var cancellables = Set<AnyCancellable>()
    
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
        
        // .tryMap(handleOutput(output:))
                   /*.sink { (completion) in
                       switch completion {
                       case .finished:
                           print("finished")
                       case .failure(let error):
                           print("HATA OLDU")
                       }
                       print("COMPLETION: \(completion)")
           
                   } receiveValue: {[weak self] product in
                       print(product)
                   }
                    */
                   // .store(in: &cancellables)
    }
       /*
       private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
           let (data, response) = output;
           guard let response = response as? HTTPURLResponse,
                 response.isGoodStatusCode else {
                     throw URLError(.badServerResponse)
                 }
           return data
       }
        */
       
       
    func makeRequest(for urlString: String) -> URLRequest? {
           guard let url = URL(string: urlString) else {
               print("Error: cannot create URL")
               return nil
           }
           // Create the request
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           return request
       }
        
}


class MockProductService: ProductServiceProtocol {
    private let defaultProducts
    = [
        Product(id: "1", name: "Elma", cost: 4.5, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: "45", name: "Domates", cost: 7.55, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: "56", name: "Biber", cost: 9.50, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: "13", name: "Armut", cost: 10.45, additionalInfo: "1 kg", category: "meyve&sebze"),
        Product(id: "75", name: "Havuç", cost: 8.5, additionalInfo: "1 kg", category: "meyve&sebze"),
        
        Product(id: "97", name: "Colgate Diş Fırçası", cost: 20.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: "9", name: "Duru Şampuan", cost: 28.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: "7", name: "Sendodyne Diş Macunu", cost: 25.5, additionalInfo: "", category: "kisiselbakim"),
        Product(id: "97", name: "Deodorant", cost: 4.5, additionalInfo: "", category: "kisiselbakim"),
      ]
    
    private let products: [Product]
    
    init(data: [Product]? = nil) {
        self.products = data ?? defaultProducts
    }
    
    func getProductsBy(category: String) -> AnyPublisher<[Product], Error> {
        let filteredProducts = products.filter { $0.category == category}
        return Just(filteredProducts)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    
}

enum ProductCategories: String {
    case meyveSebze = "meyve&sebze"
    case kisiselBakim = "kisiselbakim"
    case atistirmalik = "atistirmalik"
    case temelGida = "temelgida"
    /*
    func includes(product: Product) -> Bool {
        return product.
    }
     */
}
