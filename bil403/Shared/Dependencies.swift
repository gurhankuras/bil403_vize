//
//  Dependencies.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/18/21.
//

import Foundation

// simdilik kullanıyorum stateless servisleri birden fazla class ile paylasmak istiyorum
// yine de singleton kullanmak pek hosuma gitmiyor
class Dependencies {
    static var instance: Dependencies!
    
    let networkService: NetworkServiceProtocol
    let productService: ProductServiceProtocol
    
    private init(
        networkService: NetworkServiceProtocol,
        productService: ProductServiceProtocol
        
    ) {
        self.networkService = networkService
        self.productService = productService
        print("DEPENDENCIES INITILIAZED")
    }
    
    static func initiliase(networkService: NetworkServiceProtocol,  productService: ProductServiceProtocol){
        guard let _ = instance else {
            Self.instance = Dependencies(networkService: networkService, productService: productService)
            return
        }
        return
    }
    
    /*
    private func configureDependencies(env: Env) {
        switch env {
        case .dev:
            forProduction()
        case .prod:
            forDevelopment()
        }
        
    }
    
    private func forProduction() {
        networkService = NetworkService(session: URLSession.shared)
    }
    
    private func forDevelopment() {
        networkService = NetworkService(session: URLSession.shared)
    }
     */
}


enum Env {
    case prod
    case dev
}
