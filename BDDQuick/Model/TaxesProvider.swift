//
//  TaxesProvider.swift
//  BDDQuick
//
//  Created by Fernando Martín Ortiz on 18/11/2020.
//

import Foundation

protocol TaxesProviderType {
    func taxes(for country: Country) -> [Tax]
}

struct TaxesProvider: TaxesProviderType {
    func taxes(for country: Country) -> [Tax] {
        switch country {
        case .argentina:
            return [
                Tax(name: "IVA", rate: 0.21)
            ]
        default:
            return [
                Tax(name: "Sample tax", rate: 0.15),
                Tax(name: "Another sample tax", rate: 0.15),
            ]
        }
    }
}
