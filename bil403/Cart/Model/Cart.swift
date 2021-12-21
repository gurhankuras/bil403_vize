//
//  Cart.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation
import Combine

final class Cart: ObservableObject {
    // private let networkService: NetworkServiceProtocol
    private var productService: ProductServiceProtocol
    var cancellable: AnyCancellable?
    
    @Published var items = [Int: CartItem]()
    @Published var loading = false
    @Published var totalAmount = 0.0
    
    init(productService: ProductServiceProtocol, data: [Int: CartItem] = [:]) {
        self.items = data
        self.productService = productService
    }
    
    enum CartError: Error {
        case keyNotFound
    }

    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    func toList() -> [CartItem] {
        return items.map { (_, value) in
            return value
        }
    }
    func add(product: Product) {
        /*
        guard let url = networkService.makeRequest(to: Endpoint.stock(for: product.id), with: 1, method: .delete)  else {
            print("URL is malformed")
            return
        }
        
        cancellable = networkService
            .publisher(for: url, responseType: ApiMessage.self, decoder: JSONDecoder())
         */
        cancellable = productService.reduceStock(for: product.id)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("ERROR")
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
                self?.cancellable?.cancel()
                
            }, receiveValue: { [weak self] message in
                guard let self = self else {
                    return
                }
                self.objectWillChange.send()
                guard let existingItem = self.items[product.id] else {
                    let item = CartItem(product: product, count: 1)
                    self.items.updateValue(item, forKey: product.id)
                    self.totalAmount = self.calculateTotalAmount()
                    return
                }
                
                let updatedItem = CartItem(product: existingItem.product, count: existingItem.count + 1)
                self.items.updateValue(updatedItem, forKey: product.id)
                self.totalAmount = self.calculateTotalAmount()
            })
            
    }
    
    // TODO: TEST
    func remove(product: Product) throws {
        guard let existingItem = items[product.id] else {
            throw CartError.keyNotFound
        }
        objectWillChange.send()
        
        if existingItem.count == 1 {
            items.removeValue(forKey: existingItem.product.id)
        }
        else {
            let updatedItem = CartItem(product: existingItem.product, count: existingItem.count - 1)
            items.updateValue(updatedItem, forKey: product.id)
        }
        totalAmount = calculateTotalAmount()
    }

    
    func clear() {
        if items.isEmpty {
            return
        }
        items.removeAll()
        totalAmount = calculateTotalAmount()
    }
    
    func calculateTotalAmount() -> Double {
        var totalAmount = 0.0
        items.forEach { (id, item) in
            totalAmount += (item.product.cost * Double(item.count))
        }
        return totalAmount
    }
    
    // TEST
    func toOrder(addressId: Int, paymentMethod: Int) -> Order {
        let items = toList()
        let bundles: [ProductBundle] = items.map { cartItem in
            let bundle = ProductBundle(productId: cartItem.product.id, count: cartItem.count)
            return bundle
        }
        
        return Order(userId: 1, addressId: addressId, paymentMethodId: paymentMethod, purchasedItems: bundles)
    }
}

extension Cart {
    // for testing
    func setProductService(service: ProductServiceProtocol) {
        self.productService = service
    }
}
