//
//  BitcoinPriceViewModel.swift
//  BitcoinPriceApp
//
//  Created by Faizan Akbar on 26/01/2024.
//

import Foundation
import Combine

final class BitcoinPriceViewModel: ObservableObject {
    @Published private(set) var lastUpdated: String = ""
    @Published private(set) var priceDetails: [PriceDetails] = Currency.allCases.map { PriceDetails(currency: $0) }
    
    private let apiService = CoinDeskAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    func onAppear() {
        print("ON APPEAR IS BEING CALLED")
        loadCurrencyData()
    }
    
    private func loadCurrencyData() {
        apiService.loadCurrencyData { [weak self] welcomeModel in
            guard let self, let welcomeModel else { return }
            
            DispatchQueue.main.async {
                self.priceDetails.removeAll()
                self.lastUpdated = welcomeModel.time.updated
                
                let usdPrice = PriceDetails(currency: .usd, rate: welcomeModel.bpi.usd.rate)
                let eurPrice = PriceDetails(currency: .eur, rate: welcomeModel.bpi.eur.rate)
                let gbpPrice = PriceDetails(currency: .gbp, rate: welcomeModel.bpi.gbp.rate)
                
                self.priceDetails.append(usdPrice)
                self.priceDetails.append(eurPrice)
                self.priceDetails.append(gbpPrice)
            }
        }
    }
}
