//
//  ExchangeRateParseObject.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-05-31.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse

class ExchangeRateParseObject: PFObject, PFSubclassing {
    let timestamp: Int
    let numberatorCurrencyAbriviation: String
    let denominatorCurrencyAbriviation: String
    let rate: Double
    
    static func parseClassName() -> String {
        return "ExchangeRateParseObject"
    }
    
    init(jsonMapping: ExchangeRateJsonMapping) {
        timestamp = jsonMapping.timestamp
        numberatorCurrencyAbriviation = jsonMapping.numberatorCurrencyAbriviation
        denominatorCurrencyAbriviation = jsonMapping.denominatorCurrencyAbriviation
        rate = jsonMapping.rate
        super.init()
    }
}
