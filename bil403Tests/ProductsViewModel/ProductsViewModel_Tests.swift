//
//  ProductsViewModel.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/21/21.
//

import XCTest
@testable import bil403

class ProductsViewModel_Tests: XCTestCase {
    let testOffline = true
}

// MOCKED
extension ProductsViewModel_Tests {
    func test_Mocked_loadProducts_shouldSetProductsOnInitiliazation_WhenLoadingSucceeded() throws {
        let preparedProducts = [
            Product.stub(withID: 1),
            Product.stub(withID: 2),
        ]
        
        let mockViewModel = MockProductService.succedingService(products: preparedProducts)
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: mockViewModel)
        
        var fetchedProducts: [Product]?
        
        let expectation = self.expectation(description: "should fetch products")
        let cancellable = viewModel.$products
            .sink { products in
                fetchedProducts = products
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        XCTAssertEqual(fetchedProducts?.isEmpty, false)
        XCTAssertEqual(fetchedProducts?.count, preparedProducts.count)
        XCTAssertEqual(fetchedProducts, preparedProducts)
    }
    
    func test_Mock_loadProducts_productsShouldBeEmptyArrayOnInitiliazation_WhenLoadingFailed() throws {
        let mockViewModel = MockProductService.failingService()
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: mockViewModel)
        
        let expectation = self.expectation(description: "should not fulfilled and fetchedProducts must be stay as before")
        expectation.isInverted = true
        
        var fetchedProducts: [Product]?
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
            fetchedProducts = products
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        cancellable.cancel()
        XCTAssertEqual(fetchedProducts, nil)
        XCTAssertEqual(viewModel.products.isEmpty, true)
    }
}


// REMOTE testing
extension ProductsViewModel_Tests {
    func test_Remote_loadProducts_shouldSetProductsOnInitiliazation_WhenLoadingSucceeded() throws {
        try XCTSkipIf(testOffline, "Just test with Mock")
        
        let productService = ProductService(networkService: NetworkService(session: URLSession.shared))
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: productService)
        
        var fetchedProducts: [Product]?
        
        let expectation = self.expectation(description: "")
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
                fetchedProducts = products
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        XCTAssertEqual(fetchedProducts?.isEmpty, false)
    }
    
    func test_Remote_loading_shouldBeFalseWhenFetchingFinished() throws {
        try XCTSkipIf(testOffline, "Just test with Mock")
        
        let productService = ProductService(networkService: NetworkService(session: URLSession.shared))
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: productService)
        
        // test edip etmemekte kararsız kaldım true olmayabilir burada aslında
        XCTAssertEqual(viewModel.loading, true)
        
        let expectation = self.expectation(description: "")
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        XCTAssertEqual(viewModel.loading, false)
    }
}
