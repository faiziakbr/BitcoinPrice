//
//  CoinDeskAPIService.swift
//  BitcoinPriceApp
//
//  Created by Faizan Akbar on 26/01/2024.
//

import Foundation

//https://api.coindesk.com/v1/bpi/currentprice.json

final class CoinDeskAPIService {
    private var dataTask: URLSessionDataTask?
    
    func loadCurrencyData(completion: @escaping((Welcome?) -> Void)) {
        dataTask?.cancel()
        
        let urlRequest = URLRequest(url: URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!)
        
        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _, _ in
            guard let data else {
                completion(nil)
                return
            }
            
            
            let decodedData = try? JSONDecoder().decode(Welcome.self, from: data)
            if let decodedData {
                completion(decodedData)
            } else {
                completion(nil)
            }
        })
        dataTask?.resume()
    }
}

struct Welcome: Codable {
    let time: Time
//    let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: CurrencyModel

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct CurrencyModel: Codable {
    let code, symbol, rate, description: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate, description
        case rateFloat = "rate_float"
    }
}

// MARK: - Time
struct Time: Codable {
    let updated: String
    let updatedISO: String
    let updateduk: String
}

// 30:51
