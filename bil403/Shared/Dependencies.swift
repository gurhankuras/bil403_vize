//
//  Dependencies.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/18/21.
//

import Foundation

// singleton lifetime olmasını istedigim dependency'leri inject etmenin daha iyi bir yolunu
// bulana kadar bunu kullanacağım. Her ne kadar bu çözümü ya da service locater'ı kullanmak istemesem de
class Dependencies {
    static var instance: Dependencies!
    
    var networkService: NetworkServiceProtocol!
    lazy var productService: ProductServiceProtocol = {
        if self.env == .prod {
            return ProductService(networkService: networkService)
        }
        return ProductService(networkService: networkService)
    }()
    
    let env: Env
    private init(env: Env) {
        self.env = env
        configureDependencies(env: env)
        print("DEPENDENCIES INITILIAZED")
    }
    
    static func initiliase(env: Env) {
        Self.instance = Dependencies(env: env)
    }
    
    private func configureDependencies(env: Env) {
        switch env {
        case .dev:
            forProduction()
        case .prod:
            forDevelopment()
        }
        
    }
    
    private func forProduction() {
        print("BURADAYIM HELP ME")
        networkService = NetworkService()
    }
    
    private func forDevelopment() {
        print("BURADAYIM HELP ME")
        networkService = NetworkService()
    }
}




enum Env {
    case prod
    case dev
}
