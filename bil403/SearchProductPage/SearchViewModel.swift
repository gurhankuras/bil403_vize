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

    
    var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
