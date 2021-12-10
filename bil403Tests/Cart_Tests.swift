//
//  Cart_Tests.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import XCTest
@testable import bil403

class Cart_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        let product = Product(id: "1", name: "Elma", cost: 4.4, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let cartItem = CartItem(product: product, count: 1)
        
        let cart = Cart(data: [product.id: cartItem])
        
        XCTAssertTrue(!cart.isEmpty)
    }
        
    
    // MARK: add()
    func test_Cart_add_shouldAddItemIfNotExists() {
        let cart = Cart()
        let product = anyProduct
        
        // Act
        cart.add(product: product)
        
        // Assert
        XCTAssertFalse(cart.isEmpty)
    }
    
    func test_Cart_add_totalAmountShouldBeChangedWhenAddedNonFreeItem() {
        let cart = Cart()
            
        let expectedTotalAmount = Double.random(in: 1..<10)
        let product = Product(id: anyString, name: anyString, cost: expectedTotalAmount, additionalInfo: anyString, category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product)
        
        let totalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
    
    func test_Cart_add_shouldBeStackedWhenSameItemAdded() {
        let cart = Cart()
            
        let product1 = Product(id: "1", name: "Elma", cost: 2.5, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: "1", name: "Elma", cost: 2.5, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        print(cart.items)
        XCTAssertEqual(cart.items.count, 1)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentItem() {
        let cart = Cart()
            
        let price1 = 2.5
        let price2 = 5.5
        
        let product1 = Product(id: "1", name: "Elma", cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: "2", name: "Armut", cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        let expectedTotalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, price1 + price2)
    }
    func test_Cart_add_shouldBeStackedCorrectly() {
        let cart = Cart()
            
        let price1 = 2.5
        let price2 = 5.5
        let price3 = price1
        
        let product1 = Product(id: "1", name: "Elma", cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: "2", name: "Armut", cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product3 = Product(id: "1", name: "Elma", cost: price3, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        cart.add(product: product3)
        
        XCTAssertEqual(cart.items.count, 2)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentOneSameItem() {
        let cart = Cart()
            
        let price1 = 2.5
        let price2 = 5.5
        let price3 = price1
        
        let product1 = Product(id: "1", name: "Elma", cost: price1, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: "2", name: "Armut", cost: price2, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product3 = Product(id: "1", name: "Elma", cost: price3, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        cart.add(product: product3)
        
        
        let expectedTotalAmount = price1 + price2 + price3
        let totalAmount = cart.calculateTotalAmount()
        
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
    
    
    
    // MARK: totalAmount
    func test_Cart_totalAmount_publishedTotalAmountShouldChangeWhenProductThatHasNotBeenAddedToCartAdded() {
        let cart = Cart()
        
        let price = 4.7
        let product1 = Product(id: "1", name: "Elma", cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)

        
        // Act
        cart.add(product: product1)
        let expectedTotalAmount = price

        XCTAssertEqual(expectedTotalAmount, cart.totalAmount)
    }
    
    func test_Cart_add_publishedTotalAmountShouldChangeWhenSameProductAdded() {
        let cart = Cart()
        
        let price = 4.7
        let product1 = Product(id: "1", name: "Elma", cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)
        let product2 = Product(id: "1", name: "Elma", cost: price, additionalInfo: "", category: ProductCategories.meyveSebze.rawValue)

        
        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        let expectedTotalAmount = 2 * price

        XCTAssertEqual(expectedTotalAmount, cart.totalAmount)
    }
    
    
    /// use this when product properties doesn't matter
    private var anyProduct: Product {
        return Product(id: anyString, name: anyString, cost: anyDouble, additionalInfo: anyString, category: ProductCategories.meyveSebze.rawValue)
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
