//
//  BitcoinPriceAppApp.swift
//  BitcoinPriceApp
//
//  Created by Faizan Akbar on 26/01/2024.
//

import SwiftUI

@main
struct BitcoinPriceAppApp: App {
    var body: some Scene {
        WindowGroup {
            BitcoinPriceView(viewModel: BitcoinPriceViewModel())
        }
    }
}
