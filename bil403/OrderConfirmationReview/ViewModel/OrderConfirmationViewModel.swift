//
//  OrderConfirmationViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

class ApiMessage: Decodable {
    let message: String
}

class OrderConfirmationViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var operationResultMessage: String? = nil
    @Published var showMessage: Bool = false
    
    weak var cart: Cart?

    var cancellables = Set<AnyCancellable>()
   
    func setCart(cart: Cart) {
        self.cart = cart
    }
    
    init() {
        $showMessage.sink {[weak self] show in
            if !show {
                self?.operationResultMessage = nil
            }
        }
        .store(in: &cancellables)
    }
   
    func order(order: Order) {
        guard let request = makePostRequest(urlStr: ApiURL.order(), body: order.toDict()) else {
            return
        }
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: ApiMessage.self, decoder: JSONDecoder())
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
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    

    private func makePostRequest(urlStr: String, body: [String: Any]) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        /*
        guard let parameters = processInputs() else {
            return nil
        }
         */
        let parameters = body
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        // Create the request
        return request
    }
}
