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
    // Note we cannot override PFObject's init method (this will cause the app to throw an exception)
    // We use a convience init instead, but that means we can't have let properties so we have implicitly
    // unwrapped optional var properties with private setters instead 
    private(set) var timestamp: Int!
    private(set) var  numberatorCurrencyAbriviation: String!
    private(set) var  denominatorCurrencyAbriviation: String!
    private(set) var  rate: Double!
    
    static func parseClassName() -> String {
        return "ExchangeRateParseObject"
    }
    
    convenience init(jsonMapping: ExchangeRateJsonMapping) {
        self.init()
        timestamp = jsonMapping.timestamp
        numberatorCurrencyAbriviation = jsonMapping.numberatorCurrencyAbriviation
        denominatorCurrencyAbriviation = jsonMapping.denominatorCurrencyAbriviation
        rate = jsonMapping.rate
    }
}
