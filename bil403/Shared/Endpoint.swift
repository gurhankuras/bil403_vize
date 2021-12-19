//
//  Endpoint.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation

/// https://www.swiftbysundell.com/articles/constructing-urls-in-swift/
///
struct Endpoint {
    static let port = 5000
    static let host = "localhost"
    static let schema = "http"
    
    let path: String
    let queryItems: [URLQueryItem]
}


extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = Self.schema
        components.host = Self.host
        components.path = path
        components.port = Self.port
        components.queryItems = queryItems

        return components.url
    }
}


enum Sorting: String {
    case numberOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
}

extension Endpoint {
    static func search(matching query: String,
                       sortedBy sorting: Sorting = .recency) -> Endpoint {
        return Endpoint(
            path: "/api/products",
            queryItems: [
                URLQueryItem(name: "q", value: query),
            ]
        )
    }
    
    static func user(for userId: Int) -> Endpoint {
        return Endpoint(
            path: "/api/users/\(userId)",
            queryItems: []
        )
    }
    
    static func products(by category: ProdCategory) -> Endpoint {
        return Endpoint(
            path: "/api/products",
            queryItems: [
                URLQueryItem(name: "category", value: category.rawValue)
            ]
        )
    }
    
    static func addresses(for userId: Int) -> Endpoint {
        return Endpoint(
            path: "/api/users/\(userId)/address",
            queryItems: []
        )
    }
    
    static func ads() -> Endpoint {
        return Endpoint(
            path: "/api/ads",
            queryItems: []
        )
    }
    
    static func paymentMethods(for userId: Int) -> Endpoint {
        return Endpoint(
            path: "/api/users/\(userId)/credit-cards",
            queryItems: []
        )
    }
    
    static func order() -> Endpoint {
        return Endpoint(
            path: "/api/order",
            queryItems: []
        )
    }
    
    static func stock(for productId: Product.ID) -> Endpoint {
        return Endpoint(
            path: "/api/products/\(productId)/stock",
            queryItems: []
        )
    }
    
}

enum ProdCategory: String {
    case meyveSebze = "meyvesebze"
    case kisiselBakim = "kisiselbakim"
    case atistirmalik = "atistirmalik"
    case temelGida = "temelgida"
}

