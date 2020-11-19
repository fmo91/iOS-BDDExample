//
//  TaxCalculatorTests.swift
//  BDDQuickTests
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Quick
import Nimble
@testable import BDDQuick

final class TaxCalculatorTests: QuickSpec {
    override func spec() {
        describe("The tax calculator") {
            var provider: TaxesProviderMock!
            var calculator: TaxCalculator!
            
            beforeEach {
                provider = TaxesProviderMock()
                calculator = TaxCalculator(for: .argentina, provider: provider)
            }
            
            context("When it is asked to calculate on no taxes") {
                beforeEach {
                    provider.taxesResponse = []
                }
                
                it("Should return the same amount, without modifications") {
                    let total = calculator.calculate(for: 100)
                    expect(total).to(equal(100))
                }
            }
            
            context("When it is asked to calculate on a tax") {
                beforeEach {
                    provider.taxesResponse = [
                        Tax(name: "IVA", rate: 0.50)
                    ]
                }
                
                it("Should calculate well") {
                    let total = calculator.calculate(for: 100)
                    expect(total).to(equal(150))
                }
            }
            
            context("When it is asked to calculate in more than one tax") {
                beforeEach {
                    provider.taxesResponse = [
                        Tax(name: "Tax one", rate: 0.50),
                        Tax(name: "Tax two", rate: 0.50),
                        Tax(name: "Tax three", rate: 0.21),
                    ]
                }
                
                it("Should calculate well") {
                    let total = calculator.calculate(for: 100)
                    expect(total).to(equal(221))
                }
            }
        }
    }
}
