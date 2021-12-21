//
//  MyPaymentMethodsViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

final class MyPaymentMethodsViewModel: ObservableObject {
    @Published var paymentMethods = [PaymentMethod]()
    @Published var loading: Bool = false

    
    deinit {
        
        print("\(Self.self) DEINIT")
    }
    var cancellables = Set<AnyCancellable>()
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        loadMethods()
    }
    
    
    func loadMethods() {
        guard let url = Endpoint.paymentMethods(for: 1).url else {
            return
        }
        
        loading = true
        networkService.publisher(for: url, responseType: [PaymentMethod].self)
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
    
            } receiveValue: {[weak self] paymentMethods in
                self?.paymentMethods = paymentMethods
            }
            .store(in: &cancellables)
        
    }
}
