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

    deinit {
        print("\(Self.self) DEINIT")
    }
    
    var cancellables = Set<AnyCancellable>()

    private let productService: ProductServiceProtocol

    init(productService: ProductServiceProtocol) {
        self.productService = productService
        setupIncrementalSearch()
    }
    
    func setupIncrementalSearch() {
        $query
        .dropFirst()
        .debounce(for: 0.6, scheduler: DispatchQueue.main)
        .map({ $0.trimmingCharacters(in: .whitespaces) })
        .filter({ !$0.isEmpty})
        .map({
            return self.productService.search(matching: $0)
                .replaceError(with: [])
                .eraseToAnyPublisher()
        })
        .switchToLatest()
        .removeDuplicates(by: { $0 == $1 })
        .sink { [weak self] products in
            print("Receive value'ya girdi")
            self?.products = products
            self?.loading = false
        }
        .store(in: &cancellables)
    }
    
}
