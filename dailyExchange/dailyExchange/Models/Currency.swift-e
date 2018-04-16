//
//  Currencies.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-19.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation


struct Currency {
    static private let currencyListFileName = "currencyList"
    static private let currencyListExtention = "json"
    
    let fullName: String
    let abriviation: String
    
    static func filePathForCurrencyList() -> URL? {
        let path = Bundle.main.path(forResource: currencyListFileName, ofType: currencyListExtention)
        
        if let path = path {
            return URL(fileURLWithPath: path)
        } else {
            return nil
        }
    }
}
