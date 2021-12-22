//
//  NetworkService.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/18/21.
//

import Foundation
import Combine

// https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
        print("NetworkService initiliazed!")
    }

    func publisher<T: Decodable>(
            for url: URL,
            responseType: T.Type = T.self,
            decoder: JSONDecoder = .init()
        ) -> AnyPublisher<T, Error> {
            session.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(handleOutput(output:))
                .decode(type: T.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    
    func publisher<T: Decodable>(
            for url: URLRequest,
            responseType: T.Type = T.self,
            decoder: JSONDecoder = .init()
        ) -> AnyPublisher<T, Error> {
            session.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(handleOutput(output:))
                .decode(type: T.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
}

extension NetworkService {
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    
    func makeRequest<T: Encodable>(to endpoint: Endpoint, with encodable: T, method: HTTPMethod = .post) -> URLRequest? {
        guard let url = endpoint.url else {
            print("Error: cannot create URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let bodyData = try? JSONEncoder().encode(encodable) else {
            print("Error: cannot encode object")
            return nil
        }
        
        request.httpBody = bodyData

        return request
    }

}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}
