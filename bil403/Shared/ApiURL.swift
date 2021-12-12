//
//  ApiURL.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation


enum ApiURL: String {
    case a = "sadasd"
    static let base = "http://localhost:5000/api"
    
    static func order() -> String {
        return Self.base + "/order"
    }
    
    static func ads() -> String {
        return Self.base + "/ads"
    }
    
    static func products(by category: String) -> String {
        return Self.base + "/products?category=\(category)"
    }

    static func addresses(userId: Int) -> String {
        return Self.base + "/users/\(userId)/address"
    }
    
    static func searchProduct(q: String) -> String {
        return Self.base + "/products?q=\(q)"
    }
    
    static func paymentMethods(for userId: Int) -> String {
        return Self.base + "/users/\(userId)/credit-cards"
    }
    
    static func user(for userId: Int) -> String {
        return Self.base + "/users/\(userId)"
    }
    

}
