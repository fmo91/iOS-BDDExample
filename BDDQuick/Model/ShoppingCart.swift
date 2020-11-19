//
//  ShoppingCart.swift
//  BDDQuick
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Foundation

final class ShoppingCart {
    enum ShoppingCartOperationError: Error {
        case noProductToSub
    }
    
    private let taxCalculator: TaxCalculatorType
    private(set) var items: [ShoppingCartItem] = []
    
    init(taxCalculator: TaxCalculatorType) {
        self.taxCalculator = taxCalculator
    }
    
    var subtotal: Double {
        return items
            .map { $0.product.price * Double($0.qty) }
            .reduce(0, +)
    }
    
    var total: Double {
        return taxCalculator.calculate(for: subtotal)
    }
    
    func add(_ product: Product, qty: Int) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            let currentItem = items[index]
            items[index] = ShoppingCartItem(product: product, qty: currentItem.qty + qty)
        } else {
            items.append(ShoppingCartItem(product: product, qty: qty))
        }
    }
    
    func subOne(_ product: Product) throws {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            let currentItem = items[index]
            let newQty = currentItem.qty - 1
            if newQty == 0 {
                items.remove(at: index)
            } else {
                items[index] = ShoppingCartItem(product: product, qty: currentItem.qty - 1)
            }
        } else {
            throw ShoppingCartOperationError.noProductToSub
        }
    }
}
