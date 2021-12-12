//
//  Cart_Tests.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import XCTest
@testable import bil403

class Cart_Tests: XCTestCase {
    
    var cart: Cart?

    override func setUpWithError() throws {
        cart = Cart()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // MARK: isEmpty()
    func test_Cart_isEmpty_shouldReturnTrueIfCartHasNoItem() {
        let cart = Cart(data: [:])
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_isEmpty_shouldHasNoItemWhenDefaultInitiliazed() {
        let cart = Cart()
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_isEmpty_shouldReturnFalseIfCartHasItem() {
        let product = Product(id: 1, name: "Elma", image: "", cost: 4.4, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let cartItem = CartItem(product: product, count: 1)
        
        let cart = Cart(data: [product.id: cartItem])
        
        XCTAssertTrue(!cart.isEmpty)
    }
        
    
    // MARK: add()
    func test_Cart_add_shouldAddItemIfNotExists() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        let product = anyProduct
        
        // Act
        cart.add(product: product)
        
        // Assert
        XCTAssertFalse(cart.isEmpty)
    }
    
    func test_Cart_add_totalAmountShouldBeChangedWhenAddedNonFreeItem() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
            
        let expectedTotalAmount = Double.random(in: 1..<10)
        let product = Product(id: anyInt, name: anyString, image: "", cost: expectedTotalAmount, additionalInfo: anyString, category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product)
        
        let totalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
    
    func test_Cart_add_shouldBeStackedWhenSameItemAdded() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
            
        let product1 = Product(id: 1, name: "Elma", image: "", cost: 2.5, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: 1, name: "Elma", image: "", cost: 2.5, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        print(cart.items)
        XCTAssertEqual(cart.items.count, 1)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentItem() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
            
        let price1 = 2.5
        let price2 = 5.5
        
        let product1 = Product(id: 1, name: "Elma", image: "", cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: 2, name: "Armut", image: "", cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        let expectedTotalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, price1 + price2)
    }
    func test_Cart_add_shouldBeStackedCorrectly() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
            
        let price1 = 2.5
        let price2 = 5.5
        let price3 = price1
        
        let product1 = Product(id: 1, name: "Elma", image: "",cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: 2, name: "Armut", image: "",cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product3 = Product(id: 1, name: "Elma", image: "", cost: price3, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        cart.add(product: product3)
        
        XCTAssertEqual(cart.items.count, 2)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentOneSameItem() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
            
        let price1 = 2.5
        let price2 = 5.5
        let price3 = price1
        
        let product1 = Product(id: 1, name: "Elma", image: "", cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: 2, name: "Armut", image: "", cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product3 = Product(id: 1, name: "Elma", image: "", cost: price3, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        cart.add(product: product3)
        
        
        let expectedTotalAmount = price1 + price2 + price3
        let totalAmount = cart.calculateTotalAmount()
        
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
}


extension Cart_Tests {
    
    // MARK: totalAmount
    func test_Cart_totalAmount_publishedTotalAmountShouldChangeWhenProductThatHasNotBeenAddedToCartAdded() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        let price = 4.7
        let product1 = Product(id: 1, name: "Elma", image: "", cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)

        
        // Act
        cart.add(product: product1)
        let expectedTotalAmount = price

        XCTAssertEqual(expectedTotalAmount, cart.totalAmount)
    }
    
    func test_Cart_totalAmount_publishedTotalAmountShouldChangeWhenSameProductAdded() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        let price = 4.7
        let product1 = Product(id: 1, name: "Elma", image: "", cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: 1, name: "Elma", image: "",cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)

        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        let expectedTotalAmount = 2 * price

        XCTAssertEqual(expectedTotalAmount, cart.totalAmount)
    }
}



// MARK: remove
extension Cart_Tests {
    func test_Cart_remove_shouldThrowCartErrorIfKeyNotFound() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        XCTAssertTrue(cart.isEmpty)
        
        var thrownError: Cart.CartError?
        let expectedError = Cart.CartError.keyNotFound
        
        XCTAssertThrowsError(try cart.remove(product: anyProduct), "") { error in
            thrownError = error as? Cart.CartError
        }
        
        XCTAssertEqual(expectedError, thrownError)
    }
    
    func test_Cart_remove_cartItemShouldBeRemovedIfOnlyOneProductInBundle() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        // Given
        let product = anyProduct
        cart.add(product: product)
        XCTAssertTrue(!cart.isEmpty)
        
        guard let _ = try? cart.remove(product: product) else {
            XCTFail()
            return
        }
        
        let expectedExists = false
        
        let exists = cart.items.contains { (key, value) in
            key == product.id
        }
        
        XCTAssertEqual(expectedExists, exists)
    }
    
    func test_Cart_remove_cartItemShouldNotBeRemovedIfThereIsAtLeastOneProduct() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        // Given
        let product = anyProduct

       
        cart.add(product: product)
        cart.add(product: product)
    
        XCTAssertTrue(!cart.isEmpty)
        
        guard let _ = try? cart.remove(product: product) else {
            XCTFail()
            return
        }
        
        let expectedExists = true
        
        let exists = cart.items.contains { (key, value) in
            key == product.id
        }
        
        XCTAssertEqual(expectedExists, exists)
        
        let expectedCount = 1
        let count = cart.items[product.id]?.count
        
        XCTAssertEqual(expectedCount, count)
    }
    
}



// MARK: UTILITY
extension Cart_Tests {
    /// use this when product properties doesn't matter
    private var anyProduct: Product {
        return Product(id: anyInt, name: anyString, image: "",cost: anyDouble, additionalInfo: anyString, category: ProductCategories.meyveSebze.rawValue)
    }
    
    private var anyString: String {
        return ""
    }
    
    private var anyDouble: Double {
        return Double.random(in: 0...10)
    }
    
    private var anyInt: Int {
        return Int.random(in: 0...10)
    }
}


// MARK: clear()
extension Cart_Tests {
    func test_Cart_clear_AllItemsShouldBeRemovedIfAny() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        cart.add(product: anyProduct)
        cart.add(product: Product(id: 54, name: "Makarna", image: "",cost: 34.5, additionalInfo: "", category: ProductCategories.temelGida.rawValue))
        
        cart.clear()
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_clear_totalAmountShouldBeZero() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        cart.add(product: anyProduct)
        cart.add(product: Product(id: 54, name: "Makarna", image: "",cost: 34.5, additionalInfo: "", category: ProductCategories.temelGida.rawValue))
        
        cart.clear()
        
        XCTAssertEqual(cart.totalAmount, 0.0)
    }
    
    func test_Cart_clear_nothingShouldChangeIfAlreadyEmpty() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        let beforeCount = cart.items.count
        let beforeTotalAmount = cart.totalAmount
        
        cart.clear()
        
        let afterCount = cart.items.count
        let afterTotalAmount = cart.totalAmount
        
        XCTAssertEqual(beforeCount, afterCount)
        XCTAssertEqual(beforeTotalAmount, afterTotalAmount)
    }
}

