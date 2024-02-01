//
//  ContentView.swift
//  BitcoinPriceApp
//
//  Created by Faizan Akbar on 26/01/2024.
//

import SwiftUI

struct BitcoinPriceView: View {
    
    @ObservedObject var viewModel: BitcoinPriceViewModel
    @State private var selectedCurrency: Currency = .usd
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Updated \(viewModel.lastUpdated)")
                .padding([.top, .bottom])
                .foregroundColor(.bitcoinGreen)
            
            TabView(selection: $selectedCurrency) {
                ForEach(viewModel.priceDetails.indices, id: \.self) { index in
                    let details = viewModel.priceDetails[index]
                    PriceDetailsView(priceDetails: details)
                        .tag(details.currency)
                }
            }
            .tabViewStyle(.automatic)
            
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Picker(selection: $selectedCurrency, label: Text("Currency"), content: {
                        Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
                        Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
                        Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
                    })
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: viewModel.onAppear, label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title3)
                    })
                    .padding(.trailing)
                }
                
                Link("Powered by CoinDesk", destination: URL(string: "https://coindesk.com/price/bitcoin")!)
                    .font(.caption)
            }
            .foregroundColor(.bitcoinGreen)
        }
        .onAppear(perform: viewModel.onAppear)
        .pickerStyle(.menu)
    }
}

struct PriceDetailsView: View {
    let priceDetails: PriceDetails
    
    var body: some View {
        ZStack {
            Color.bitcoinGreen
            VStack {
                Text(priceDetails.currency.icon)
                    .font(.largeTitle)
                Text("1 Bitcoin = ")
                    .bold()
                    .font(.title2)
                Text("\(priceDetails.rate) \(priceDetails.currency.code)")
                    .bold()
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
    }
}

//#Preview {
//    BitcoinPriceView(viewModel: BitcoinPriceViewModel())
//}
