//
//  NetworkingManager.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-14.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation
// https://sdw-wsrest.ecb.europa.eu/service/data/EXR/M.USD.EUR.SP00.A // gets the exchange rate for USD/EUR Monthly

/*
 API
 
 // returns (DSD) Data Structure Definition for codelists for ECB (aka the currency ids)
 https://sdw-wsrest.ecb.europa.eu/service/codelist/ECB/CLI_EONIA_BANK/1.0
 
 https://sdw-wsrest.ecb.europa.eu/service/datastructure/ECB/ // DBD for Creating the URL's for fetching data 
 //
 */

class NetworkManager {
    enum resource {
        case data
        case schema
        case codelist
    }
    
    private let base = "https://sdw-wsrest.ecb.europa.eu/service/"
    
    func updateCurrencySchema() {
        
    }
    
}

