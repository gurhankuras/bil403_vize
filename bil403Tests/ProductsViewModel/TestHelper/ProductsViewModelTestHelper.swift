//
//  ProductsViewModelTestHelper.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/24/21.
//

@testable import bil403

import Foundation
import XCTest

extension ProductsViewModel_Tests {
    
    func createAnonymousProducts(count: Int) -> [Product] {
        return Array(1...count).map { Product.stub(withID: $0) }
    }
    
    func assertProductsFetched(expectedProducts: [Product], fetchedProducts: [Product]?) {
        let message = "\(#function) failed"
        
        XCTAssertEqual(fetchedProducts?.isEmpty, false, message)
        XCTAssertEqual(expectedProducts.count, fetchedProducts?.count, message)
        XCTAssertEqual(expectedProducts, fetchedProducts, message)
    }
}
