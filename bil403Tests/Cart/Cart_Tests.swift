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
    var networkService: NetworkServiceProtocol?
    var productService: ProductServiceProtocol?
    
    func makeFailingCart() -> Cart {
        return Cart(productService: MockProductService.failingService())
    }

    override func setUpWithError() throws {
        networkService = NetworkService()
        productService = ProductService(networkService: networkService!)
        cart = Cart(productService: productService!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // MARK: isEmpty()
    func test_Cart_isEmpty_shouldReturnTrueIfCartHasNoItem() {
        let cart = Cart(productService: productService!, data: [:])
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_isEmpty_shouldHasNoItemWhenDefaultInitiliazed() {
        let cart = Cart(productService: productService!)
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_isEmpty_shouldReturnFalseIfCartHasItem() {
        let product = Product.stub(withID: 1)
        let cartItem = CartItem(product: product, count: 1)
        
        let cart = Cart(productService: productService!, data: [product.id: cartItem])
        
        XCTAssertTrue(!cart.isEmpty)
    }
        
    
    // MARK: add()
    func test_Cart_add_shouldAddItemIfNotExists_whenAddingSucceeded() {
        let mockProductService = MockProductService.succedingService(products: nil, message: .init(message: "mock"))
        
        let cart = Cart(productService: mockProductService)
        
        let product = Product.stub(withID: 1)
        
        // Act
        cart.add(product: product)
        
        // Assert
        XCTAssertFalse(cart.isEmpty)
    }
    
    func test_Cart_add_shouldNotAddItemIfNotExists_whenAddingFailed() {
        let cart = makeFailingCart()
        let product = Product.stub(withID: 1)
        
        // Act
        cart.add(product: product)
        
        // Assert
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_add_totalAmountShouldBeChangedWhenAddedNonFreeItem_whenAddingSucceeded() {
        let mockProductService = MockProductService.succedingService(products: nil, message: .init(message: "mock"))
        
        let cart = Cart(productService: mockProductService)
            
        let expectedTotalAmount = Double.random(in: 1..<10)
        let product = Product.stub(withID: 2)
            .setting(\.cost, to: expectedTotalAmount)
              
        // Act
        cart.add(product: product)
        
        let totalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
    
    func test_Cart_add_totalAmountShouldNotBeChangedWhenAddedNonFreeItem_whenAddingFailed() {
        let cart = makeFailingCart()
        
        let productPrice = Double.random(in: 1..<10)
        let product = Product.stub(withID: 2)
            .setting(\.cost, to: productPrice)
        
        let totalAmountBeforeAddingAttempt = cart.calculateTotalAmount()
        
        // Act
        cart.add(product: product)
        
        let totalAmountAfterAddingAttempt = cart.calculateTotalAmount()
        XCTAssertEqual(totalAmountBeforeAddingAttempt, totalAmountAfterAddingAttempt)
    }
    
    func test_Cart_add_shouldBeStackedWhenSameItemAdded_whenAddingSucceeded() {
        let mockProductService = MockProductService.succedingService(products: nil, message: .init(message: "mock"))
        
        let cart = Cart(productService: mockProductService)
            
        let product1 = Product.stub(withID: 1)
        let product2 = Product.stub(withID: 1)

        // Act
        cart.add(product: product1)
        cart.add(product: product2)
        
        print(cart.items)
        XCTAssertEqual(cart.items.count, 1)
    }
    
    func test_Cart_add_shouldNotBeStackedWhenSameItemAdded_whenAddingFailed() {
        let succeedsMockService = MockProductService.succedingService(products: nil, message: .init(message: "mock"))
        
        let cart = Cart(productService: succeedsMockService)
            
        let product1 = Product.stub(withID: 1)
        let product2 = Product.stub(withID: 1)

        // Act
        cart.add(product: product1)
        cart.setProductService(service: MockProductService.failingService())
        cart.add(product: product2)
        
        print(cart.items)
        XCTAssertEqual(cart.items.count, 1)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentItem_whenAddingSucceded() {
        let mockProductService = MockProductService.succedingService(products: nil, message: .init(message: "mock"))
        
        let cart = Cart(productService: mockProductService)
            
        let firstProductPrice = 2.5
        let secondPricePrice = 5.5
        
        let firstAddedProduct = Product.stub(withID: 1)
                                .setting(\.cost, to: firstProductPrice)
        let secondAddedProduct = Product.stub(withID: 2)
                                .setting(\.cost, to: secondPricePrice)
        // Act
        cart.add(product: firstAddedProduct)
        cart.add(product: secondAddedProduct)
        
        let expectedTotalAmount = cart.calculateTotalAmount()
        XCTAssertEqual(expectedTotalAmount, firstProductPrice + secondPricePrice)
    }
    func test_Cart_add_shouldBeStackedCorrectly_whenAddingSucceded() {
        
        // Prepare
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
        
        let firstProductPrice = 2.5
        let secondProductPrice = 5.5
        let thirdProductPrice = firstProductPrice
        
        let firstAddedProduct = Product.stub(withID: 1)
                                .setting(\.cost, to: firstProductPrice)
        let secondAddedProduct = Product.stub(withID: 2)
                                .setting(\.cost, to: secondProductPrice)
        let thirdAddedProduct = Product.stub(withID: 1)
                                .setting(\.cost, to: thirdProductPrice)
        // Act
        cart.add(product: firstAddedProduct)
        cart.add(product: secondAddedProduct)
        cart.add(product: thirdAddedProduct)
        
        // Assert
        XCTAssertEqual(cart.items.count, 2)
    }
    
    func test_Cart_add_shouldReturnTotalAmountWhenAddedTwoDifferentOneSameItem_whenAddingSucceded() {
        // Prepare
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
            
        let firstProductPrice = 2.5
        let secondProductPrice = 5.5
        let thirdProductPrice = firstProductPrice
        
        let first = Product.stub(withID: 1)
                            .setting(\.cost, to: firstProductPrice)
        let second = Product.stub(withID: 2)
                            .setting(\.cost, to: secondProductPrice)
        let third = Product.stub(withID: 1)
                            .setting(\.cost, to: thirdProductPrice)
        // Act
        cart.add(product: first)
        cart.add(product: second)
        cart.add(product: third)
        
        let expectedTotalAmount = firstProductPrice + secondProductPrice + thirdProductPrice
        let totalAmount = cart.calculateTotalAmount()
        
        // Assert
        XCTAssertEqual(expectedTotalAmount, totalAmount)
    }
}


extension Cart_Tests {
    
    // MARK: totalAmount
    func test_Cart_totalAmount_publishedTotalAmountShouldChangeWhenProductThatHasNotBeenAddedToCartAdded_whenAddingSucceded() {
        // Prepare
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
        
        let price = 4.7
        let product = Product.stub(withID: 1)
                            .setting(\.cost, to: price)

        // Act
        cart.add(product: product)
        let expectedTotalAmount = price

        // Assert
        XCTAssertEqual(expectedTotalAmount, cart.totalAmount)
    }
    
    func test_Cart_totalAmount_publishedTotalAmountShouldChangeWhenSameProductAdded_whenAddingSucceded() {
        // Prepare
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
        
        let price = 4.7
        let firstProduct = Product.stub(withID: 1)
            .setting(\.cost, to: price)
        let secondProduct = firstProduct

        
        // Act
        cart.add(product: firstProduct)
        cart.add(product: secondProduct)
        
        let expectedTotalAmount = 2 * price

        // Assert
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
        
        XCTAssertThrowsError(try cart.remove(product: Product.stub(withID: 1)), "") { error in
            thrownError = error as? Cart.CartError
        }
        
        XCTAssertEqual(expectedError, thrownError)
    }
    
    func test_Cart_remove_cartItemShouldBeRemovedIfOnlyOneProductInBundle() {
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
        
        // Given
        let product = Product.stub(withID: 1)
        cart.add(product: product)
        
        XCTAssertTrue(!cart.isEmpty) // for more defensive
        
        guard let _ = try? cart.remove(product: product) else {
            XCTFail()
            return
        }
        
        let shouldExists = false
        
        let exists = cart.items.contains { (key, value) in
            key == product.id
        }
        
        XCTAssertEqual(shouldExists, exists)
    }
    
    func test_Cart_remove_cartItemShouldNotBeRemovedIfThereIsAtLeastOneProduct() {
        let mockProductService = MockProductService(products: nil, error: nil, message: ApiMessage(message: "ekledim"))
        
        let cart = Cart(productService: mockProductService)
        
        // Given
        let product = Product.stub(withID: 1)

       
        cart.add(product: product)
        cart.add(product: product)
    
        XCTAssertTrue(!cart.isEmpty)
        
        guard let _ = try? cart.remove(product: product) else {
            XCTFail()
            return
        }
        
        let shouldExists = true
        
        let exists = cart.items.contains { (key, value) in
            key == product.id
        }
        
        XCTAssertEqual(shouldExists, exists)
        
        
        let bundle = cart.items[product.id]

        let expectedProductCountInBundle = 1
        let countInBundle = bundle?.count
        
        XCTAssertEqual(expectedProductCountInBundle, countInBundle)
    }
    
}



// MARK: UTILITY
extension Cart_Tests {
    /// use this when product properties doesn't matter
    private var anyProduct: Product {
        return Product(id: anyInt, name: anyString, image: "",cost: anyDouble, additionalInfo: anyString, category: ProdCategory.meyveSebze.rawValue)
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
        
        cart.add(product: Product.stub(withID: 1))
        cart.add(product: Product.stub(withID: 3))
        
        cart.clear()
        
        XCTAssertTrue(cart.isEmpty)
    }
    
    func test_Cart_clear_totalAmountShouldBeZero() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        cart.add(product: Product.stub(withID: 1))
        cart.add(product: Product.stub(withID: 3))
        
        cart.clear()
        
        XCTAssertEqual(cart.totalAmount, 0.0)
    }
    
    func test_Cart_clear_nothingShouldChangeIfAlreadyEmpty() {
        guard let cart = cart else {
            XCTFail("Some problem occured related to initialization of Cart")
            return
        }
        
        XCTAssertTrue(cart.isEmpty)
        
        let beforeCount = cart.items.count
        let beforeTotalAmount = cart.totalAmount
        
        cart.clear()
        
        let afterCount = cart.items.count
        let afterTotalAmount = cart.totalAmount
        
        XCTAssertEqual(beforeCount, afterCount)
        XCTAssertEqual(beforeTotalAmount, afterTotalAmount)
    }
}

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle(for: Cart_Tests.self).path(forResource: name, ofType: ".json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}


func parse<T: Decodable>(jsonData: Data, returnType: T.Type) -> T? {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

struct ReadFileError: Error {}
struct ParsingError: Error {}

func readStub<T: Decodable>(forName: String, returnType: T.Type) throws -> T {
    guard let data = readLocalJSONFile(forName: forName) else {
        throw ReadFileError()
    }

    guard let person = parse(jsonData: data, returnType: returnType) else {
        throw ParsingError()
    }
    
    return person
}


extension Cart_Tests {
   
    
}
