//
//  SearchViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var loading: Bool = false
    @Published var query: String = ""

    
    var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    private let productService: ProductServiceProtocol = Dependencies.instance.productService
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    
        /*
        $query
            .dropFirst()
            .debounce(for: 0.6, scheduler: DispatchQueue.main)
            .flatMap({ q -> AnyPublisher<[Product], Error> in
                print(q)
               let url = Endpoint.search(matching: q).url!
                return networkService.publisher(for: url, responseType: [Product].self, decoder: .init())
                    .catch { error in
                        return Just([])
                            .setFailureType(to: Error.self)
                    }
                    .eraseToAnyPublisher()
            })
            */
        /*
        productService.search(matching: $query)
         */
        $query
            .dropFirst()
            .debounce(for: 0.6, scheduler: DispatchQueue.main)
            .flatMap({ q -> AnyPublisher<[Product], Error> in
                print(q)
                return self.productService.search(matching: q)
                    .catch { error in
                        return Just([])
                            .setFailureType(to: Error.self)
                    }
                    .eraseToAnyPublisher()
            })
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
    
            } receiveValue: {[weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
            

    }
    
    func loadProducts(query: String) {
        guard let url = Endpoint.search(matching: query).url else {
            return
        }
        
        loading = true
        networkService.publisher(for: url, responseType: [Product].self)
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
    
            } receiveValue: {[weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }

}
