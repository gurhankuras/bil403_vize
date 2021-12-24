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

// TODO: REFACTOR TESTS

// STUBBED
extension ProductsViewModel_Tests {
    
    /*
    func createOfflineSuccessfulProductsViewModel(products: [Products]) {
        let responderStubProductService = ProductServiceResponserStub(products: preparedProducts, message: nil)
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: responderStubProductService)
    }
     */
    
    
    func test_Stubbed_loadProducts_shouldSetProductsOnInitiliazation_WhenLoadingSucceeded() throws {
        // Setup
        let preparedProducts = createAnonymousProducts(count: 2)
        let responderStubProductService = ProductServiceResponserStub(products: preparedProducts, message: nil)
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: responderStubProductService)
        
        var fetchedProducts: [Product]?
        let expectation = self.expectation(description: "should fetch products")
        
        // Act
        let cancellable = viewModel.$products
            .sink { products in
                fetchedProducts = products
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        // Assert
        assertProductsFetched(expectedProducts: preparedProducts, fetchedProducts: fetchedProducts)
    }
    
    func test_Stubbed_loadProducts_productsShouldBeEmptyArrayOnInitiliazation_WhenLoadingFailed() throws {
        // Setup
        let saboteurProductService = ProductServiceSaboteurStub(error: MockError())
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: saboteurProductService)
        let expectation = self.expectation(description: "should not fulfilled and fetchedProducts must be stay as before")
        expectation.isInverted = true
        
        // Act
        var fetchedProducts: [Product]?
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
            fetchedProducts = products
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        cancellable.cancel()
        
        // Assert
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
        // Setup
        let productService = ProductService(networkService: NetworkService(session: URLSession.shared))
        let viewModel = ProductsViewModel(category: .meyveSebze, productService: productService)
        
        // test edip etmemekte kararsız kaldım true olmayabilir burada aslında
        XCTAssertEqual(viewModel.loading, true)
        
        // Act
        let expectation = self.expectation(description: "")
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        // Assert
        XCTAssertEqual(viewModel.loading, false)
    }
}
