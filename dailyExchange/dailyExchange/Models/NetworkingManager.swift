//
//  NetworkingManager.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-14.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation

/*
 API
 https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?lastNObservations=1 // Most recent exchange rate USD/EUR up to the minute averaged per minute
 https://sdw-wsrest.ecb.europa.eu/service/datastructure/ECB/ // DBD for Creating the URL's for fetching data 
 //
 */

struct ECBURLGenerator {
    static private let baseURL = "https://sdw-wsrest.ecb.europa.eu/service/"
    static private let lastNParameter = "lastNObservations="
    static private let exr = "EXR/"
    static private let sp00 = "SP00"
    
    private enum Resource: String {
        case data = "data/"
        case schema = "schema/"
        case codelist = "codelist/"
        case datastructure = "datastructure/"
    }
    
    enum URLTimeKey: String {
        case minute = "N"
        case daily = "D"
        case monthly = "M"
        case quarterly = "Q"
        case halfYear = "H"
        case annually = "A"
    }
    
    static func ecburlCompairing(last nOccurances: Int?, of currency: Currency, to baseCurrency: Currency, over timePeriod: URLTimeKey) -> String {
        
        var urlString =  "\(baseURL)\(Resource.data)/\(exr)\(timePeriod.rawValue).\(currency.abriviation).\(baseCurrency.abriviation).\(sp00).A"
        
        if let n = nOccurances {
            urlString = urlString + "?" + lastNParameter + "\(n)"
        }
        
        return urlString
    }
}

class NetworkManager {
    func exchangeRateforCurrency(_ currency: Currency, with base: Currency, completion: @escaping (String) -> ()) {
        let urlString = ECBURLGenerator.ecburlCompairing(last: 1, of: currency, to: base, over: .daily)
        let url = URL(string: urlString)!
        let downloadTask = URLSession.shared.downloadTask(with: url) { (path, response, error) in
            
            print("data: \(path); response: \(response); error: \(error)")
            
            completion("temp string")
        }
        
        downloadTask.resume()
    }
    
    
 
}



