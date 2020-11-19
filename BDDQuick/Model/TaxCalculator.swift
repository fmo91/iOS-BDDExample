//
//  TaxCalculator.swift
//  BDDQuick
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Foundation

protocol TaxCalculatorType {
    func calculate(for subtotal: Double) -> Double
}

struct TaxCalculator: TaxCalculatorType {
    private let country: Country
    private let provider: TaxesProviderType
    
    init(for country: Country, provider: TaxesProviderType = TaxesProvider()) {
        self.country = country
        self.provider = provider
    }
    
    func calculate(for subtotal: Double) -> Double {
        let currentTaxes = provider.taxes(for: country)
        let resolvedTaxes = currentTaxes
            .map { subtotal * $0.rate }
            .reduce(0, +)
        return resolvedTaxes + subtotal
    }
}
