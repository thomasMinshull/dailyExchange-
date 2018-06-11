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
    @NSManaged var timestamp: Int
    @NSManaged var numberatorCurrencyAbriviation: String
    @NSManaged var denominatorCurrencyAbriviation: String
    @NSManaged var rate: Double
    @NSManaged var notificationsEnabled: Bool
    @NSManaged var user: PFUser?
    @NSManaged var isSavedOnServer: Bool
    
    static func parseClassName() -> String {
        return "ExchangeRateParseObject"
    }
    
    convenience init(jsonMapping: ExchangeRateJsonMapping) {
        self.init()
        timestamp = jsonMapping.timestamp
        numberatorCurrencyAbriviation = jsonMapping.numberatorCurrencyAbriviation
        denominatorCurrencyAbriviation = jsonMapping.denominatorCurrencyAbriviation
        rate = jsonMapping.rate
        notificationsEnabled = true
        isSavedOnServer = false
    }
}
