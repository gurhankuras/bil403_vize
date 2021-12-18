//
//  MyAddressesViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

final class MyAddressesViewModel: ObservableObject {
    @Published var addresses = [Address]()
    @Published var loading: Bool = false

    
    var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        loadAddresses()
    }
    
    func loadAddresses() {
        guard let request = Endpoint.addresses(for: 1).url else {
            return
        }
        
        loading = true
        networkService.publisher(for: request, responseType: [Address].self)
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
    
            } receiveValue: {[weak self] addresses in
                self?.addresses = addresses
            }
            .store(in: &cancellables)
    }
}
