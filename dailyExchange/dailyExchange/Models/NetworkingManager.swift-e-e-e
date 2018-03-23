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
//        let urlString = "https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?lastNObservations=1"
         let urlString = ECBURLGenerator.ecburlCompairing(last: 1, of: currency, to: base, over: .daily)
        let url = URL(fileURLWithPath: urlString)
        
        // https://sdw-wsrest.ecb.europa.eu/service/data/EXR/M.USD.EUR.SP00.A
        let downloadTask = URLSession.shared.downloadTask(with: url) { (data, response, error) in
            /*
             NOTE: the following error will be passed if the user requests two currencies for which there is not an exchange rate for. (unfortuantly, not all exchange rates are represented in the api
             
             Error Domain=NSURLErrorDomain Code=-1100 "The requested URL was not found on this server." UserInfo={NSUnderlyingError=0x6000004484c0 {Error Domain=kCFErrorDomainCFNetwork Code=-1100 "(null)"}, NSErrorFailingURLStringKey=file:///https:/sdw-wsrest.ecb.europa.eu/service/data/EXR/D.AED.ANG.SP00.A%3FlastNObservations=1, NSErrorFailingURLKey=file:///https:/sdw-wsrest.ecb.europa.eu/service/data/EXR/D.AED.ANG.SP00.A%3FlastNObservations=1, NSLocalizedDescription=The requested URL was not found on this server.
            */
            
            print("data: \(data); response: \(response); error: \(error)")
            
            
            completion("temp string")
        }
        
        downloadTask.resume()
    }
 
}



