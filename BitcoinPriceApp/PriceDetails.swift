//
//  PriceDetails.swift
//  BitcoinPriceApp
//
//  Created by Faizan Akbar on 26/01/2024.
//

import Foundation

enum Currency: CaseIterable {
    case usd
    case gbp
    case eur
    
    var icon: String {
        switch self {
        case .usd:
            "﹩"
        case .gbp:
            "£"
        case .eur:
            "€"
        }
    }
    
    var code: String {
        switch self {
        case .usd:
            "USD"
        case .gbp:
            "GBP"
        case .eur:
            "EUR"
        }
    }
}

struct PriceDetails {
    let currency: Currency
    let rate: String
    
    init(currency: Currency, rate: String = "--") {
        self.currency = currency
        self.rate = rate
    }
}
