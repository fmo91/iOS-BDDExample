//
//  TaxesProviderMock.swift
//  BDDQuickTests
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Foundation
@testable import BDDQuick

final class TaxesProviderMock: TaxesProviderType {
    var taxesResponse: [Tax] = []
    
    func taxes(for country: Country) -> [Tax] {
        return taxesResponse
    }
}
