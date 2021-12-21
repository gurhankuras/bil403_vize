//
//  NetworkServiceProtocol.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/20/21.
//

import Foundation
import Combine

// https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/

protocol NetworkServiceProtocol {
    
    func publisher<T: Decodable>(
            for url: URL,
            responseType: T.Type,
            decoder: JSONDecoder
        ) -> AnyPublisher<T, Error>
    
    func publisher<T: Decodable>(
            for url: URLRequest,
            responseType: T.Type,
            decoder: JSONDecoder
        ) -> AnyPublisher<T, Error>
    
    func makeRequest<T: Encodable>(to endpoint: Endpoint, with encodable: T, method: HTTPMethod) -> URLRequest?
}

extension NetworkServiceProtocol {
    
    func publisher<T: Decodable>(
            for url: URL,
            responseType: T.Type,
            decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        return publisher(for: url, responseType: responseType, decoder: decoder)
    }
    
    func publisher<T: Decodable>(
            for url: URLRequest,
            responseType: T.Type,
            decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        return publisher(for: url, responseType: responseType, decoder: decoder)
    }
}
