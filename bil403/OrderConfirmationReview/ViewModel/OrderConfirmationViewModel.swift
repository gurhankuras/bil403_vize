//
//  OrderConfirmationViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

struct ApiMessage: Decodable {
    let message: String
}

final class OrderConfirmationViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var operationResultMessage: String? = nil
    @Published var showMessage: Bool = false
    
    private let networkService: NetworkServiceProtocol
    weak var cart: Cart?

    var cancellables = Set<AnyCancellable>()
   
    func setCart(cart: Cart) {
        self.cart = cart
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        $showMessage.sink {[weak self] show in
            if !show {
                self?.operationResultMessage = nil
            }
        }
        .store(in: &cancellables)
    }
   
    func order(order: Order) {
        
        guard let request = networkService.makeRequest(to: Endpoint.order(), with: order, method: .post) else {
            return
        }
        
        loading = true
        
        networkService.publisher(for: request, responseType: ApiMessage.self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    self?.cart?.clear()
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
                self?.loading = false
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
                self?.operationResultMessage = msg.message
                self?.showMessage = true
            }
            .store(in: &cancellables)
    }
}
