//
//  Currencies.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-19.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation


struct Currency {
    static private let cachedCurrencySchemeFileName = "cachedCurrencyScheme.xml"
    
    let fullName: String
    let abriviation: String
    
    static func filePathForCurrencySchema() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).last
        let cashedFileURL = documentsDirectory?.appendingPathComponent(cachedCurrencySchemeFileName)
        
        if let result = (try? cashedFileURL?.checkResourceIsReachable()),
            result == true
        {
            return cashedFileURL!
        } else {
            return Bundle.main.url(forResource: "currencySchema", withExtension: "xml")!
        }
    }
    
}
