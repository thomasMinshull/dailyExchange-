//
//  exchangeRage.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-05-27.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

/*
 // JSON That is mapping to this struct
 
 {
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "timestamp": 1527456547,
    "source": "ZMK",
    "quotes": {
        "ZMKRON": 0.000439
    }
 }
 
 */

import Foundation

struct ExchangeRate: Decodable {
    enum ExchangeRateKeys: String, CodingKey {
        case timestamp
        case source
        case quotes
    }
    
    let timestamp: Int
    let numberatorCurrencyAbriviation: String
    let denominatorCurrencyAbriviation: String
    let rate: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExchangeRateKeys.self)
        timestamp = try container.decode(Int.self, forKey: .timestamp)
        denominatorCurrencyAbriviation = try container.decode(String.self, forKey: .source)
        
        
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .quotes)
        let numberatorCurrencyKey = nestedContainer.allKeys.first!
        
        numberatorCurrencyAbriviation = numberatorCurrencyKey.stringValue
        rate = try nestedContainer.decode(Double.self, forKey: numberatorCurrencyKey)
    }
}
