//
//  NetworkingManager.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-14.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation
import UIKit

/*
 API
 // list of available currencies
 https://apilayer.net/api/list?access_key=3b41cec354bb1e790c40bc82e702d359&prettyprint=1
 // currently paying $100 USD per year for this api, renews on the Jan 01 2019 // this gets me the ability to switch base currencies and https 
 
 */

struct CurrencyURLGenerator {
    static private let baseURL = URL(string: "https://apilayer.net/api")!
    static private let accessKeyQueryItem = URLQueryItem(name: "access_key", value: currencyAPIKey)
    
    enum EndPoint: String {
        case live
        case historical
        case convert
        case timeframe
        case change
    }
    
    enum QueryKey: String {
        case from
        case to
        case amount
        case date // YY-MM-DD
        case currencies
        case startDate = "start_date"
        case endDate = "end_date"
        case format
        case source
    }
    
    static func urlFor(endPoint: EndPoint, params: [QueryKey: String]) -> URL? {
        let url = baseURL.appendingPathComponent(endPoint.rawValue)
        var urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let additionalParams = params.map {
            return URLQueryItem(name: $0.key.rawValue, value: $0.value)
        }

        urlComponets?.queryItems = [accessKeyQueryItem] + additionalParams

        return urlComponets?.url
    }
}

class NetworkManager {
    
    
    func exchangeRateforCurrency(_ currency: Currency, with base: Currency, completion: @escaping (String) -> ()) {
        
        let params: [CurrencyURLGenerator.QueryKey: String] = [
            .currencies: currency.abriviation,
            .source: base.abriviation
        ]
        
        guard let url = CurrencyURLGenerator.urlFor(endPoint: .live, params: params) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                ErrorPrecentor(error: error!).pressentAlertWith(actions: [UIAlertAction]())
                return
            }
            
            guard let res = response as? HTTPURLResponse,
                res.statusCode == 200 else {
                    //TODO map error response to presentable errors
                    //TODO handle cacheing of unchanged values
                    ErrorPrecentor(error: DefaultError()).pressentAlertWith(actions: [UIAlertAction]())
                    return
            }
            
            guard let data = data else {
                print("Error, no data was returned but status Code was 200")
                return
            }
            
            guard let exchangeRate = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                print("Error, was undable to decode JSON Currency Data")
                return
            }            

            let formattedString = String(format: "%.2f", exchangeRate.rate) // note this rounds up
            completion(formattedString)
        }
        
        task.resume()
    }
}



