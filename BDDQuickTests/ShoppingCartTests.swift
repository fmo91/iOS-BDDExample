//
//  ShoppingCartTests.swift
//  BDDQuickTests
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Quick
import Nimble
@testable import BDDQuick

class ShoppingCartTests: QuickSpec {
    override func spec() {
        describe("Given the shopping cart") {
            var shoppingCart: ShoppingCart!
            
            context("When it is in Argentina") {
                beforeEach {
                    shoppingCart = ShoppingCart(taxCalculator: TaxCalculator(for: .argentina))
                }
                
                context("When it has a product in it") {
                    beforeEach {
                        shoppingCart.add(Product(id: 10, price: 200), qty: 1)
                    }
                    
                    context("When we add the same product to it") {
                        beforeEach {
                            shoppingCart.add(Product(id: 10, price: 200), qty: 3)
                        }
                        
                        it("Should sum quantities for both of them") {
                            expect(shoppingCart.subtotal).to(equal(800))
                        }
                        
                        it("Should calculate the total accordingly") {
                            expect(shoppingCart.total).to(equal(968))
                        }
                    }
                    
                    context("When the user removes the product") {
                        var receivedError: Error!
                        
                        beforeEach {
                            receivedError = nil
                            do {
                                try shoppingCart.subOne(Product(id: 10, price: 200))
                            } catch let error {
                                receivedError = error
                            }
                        }
                        
                        it("Should have zero as its total") {
                            expect(shoppingCart.total).to(equal(0))
                            expect(receivedError).to(beNil())
                        }
                    }
                    
                    context("When the user removes a non existent product") {
                        var receivedError: Error!
                        
                        beforeEach {
                            receivedError = nil
                            do {
                                try shoppingCart.subOne(Product(id: 100, price: 21))
                            } catch let error {
                                receivedError = error
                            }
                        }
                    
                        it("Should return an error") {
                            expect(receivedError).toNot(beNil())
                        }
                    }
                }
            }
        }
    }
}
