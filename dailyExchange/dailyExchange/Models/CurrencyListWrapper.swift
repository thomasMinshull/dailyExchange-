//
//  CurrencyList.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-04-13.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

// deserializes currencies form currencyList.json file

/* JSON we are converting
 {
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "currencies": {
        "AED": "United Arab Emirates Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek" ...
    }
 }
 
 */

import Foundation

struct CurrencyListWrapper: Codable {
    enum WrapperKeys: String, CodingKey {
        case terms
        case privacy
        case currencies
        case success
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WrapperKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .currencies)
        
        var currencies: [Currency] = []
        
        do {
            for key in nestedContainer.allKeys {
                
                let name = try nestedContainer.decode(String.self, forKey: key)
                
                let currency = Currency(fullName: name, abriviation: key.stringValue)
                currencies.append(currency)
            }
            
            self.currencies = currencies
        } catch {
            self.currencies = []
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKey.self)
        
        for currency in currencies {
            if let key = DynamicCodingKey(stringValue: currency.abriviation) {
                try container.encode(currency.fullName, forKey: key)
            }
        }
    }
    
    var currencies: [Currency]
}
