//
//  ProfileViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var user: User?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadUser()
    }
    
    
    func loadUser() {
        guard let request = makeGetRequest(urlStr: ApiURL.user(for: 1)) else {
            return
        }
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: User.self, decoder: JSONDecoder())
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
    
            } receiveValue: {[weak self] user in
                self?.user = user
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
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request
        return request
    }
}
