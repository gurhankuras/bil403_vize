//
//  ProfileViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var user: User?
    
    var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        loadUser()
    }
    
    
    func loadUser() {
        guard let url = Endpoint.user(for: 1).url else {
            return;
        }
        
        loading = true
        networkService.publisher(for: url, responseType: User.self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("SUCCESS")
                case .failure(let error):
                    print("HATA OLDU \(error)")
                }
                self?.loading = false
    
            } receiveValue: {[weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
