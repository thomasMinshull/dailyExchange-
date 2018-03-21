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
 https://sdw-wsrest.ecb.europa.eu/service/datastructure/ECB/ECB_EXR1/1.0?references=children // Not Working
 
 https://sdw-wsrest.ecb.europa.eu/service/datastructure/ECB/ // DBD for Creating the URL's for fetching data 
 //
 */

class NetworkManager{
    enum Resource: String {
        case data = "data/"
        case schema = "schema/"
        case codelist = "codelist/"
        case datastructure = "datastructure/"
    }
    
    private let base = "https://sdw-wsrest.ecb.europa.eu/service/"
    
    func updateCurrencySchema(completion: @escaping () -> ()) {
        let codeListURLString = base + Resource.datastructure.rawValue + "ECB/ECB_EXR1/1.0?references=children"
        let codeListURL = URL(string: codeListURLString)!
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: codeListURL)
        
        let task = session.downloadTask(with: request) { (localTempURL, response, error) in
            if let tempLocalUrl = localTempURL, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)") // ToDo handle error's and status codes
                }
                
                if let filePathForCachedSchema = Currency.filePathForCachedSchema() {
                    do {
                        if try filePathForCachedSchema.checkResourceIsReachable() {
                            // Previously Cached
                            try _ = FileManager.default.replaceItemAt(filePathForCachedSchema,
                                                                      withItemAt: tempLocalUrl)
                        } else {
                            /*
                             checkResourceIsReachable does NOT return false if file does not exist
                             (I assume it is actually checking if user has permissions to access
                             the file? the documentation is unclear)
                             */
                            // To Do what to do in this case if we just don't have permisions?
                            try FileManager.default.copyItem(at: tempLocalUrl, to: filePathForCachedSchema)
                        }
                    } catch let error as NSError {
                        if error.domain == NSCocoaErrorDomain,
                            error.code == 260
                        {
                            do {
                                try FileManager.default.copyItem(at: tempLocalUrl, to: filePathForCachedSchema)
                            } catch {
                                print("error writing file \(tempLocalUrl) : \(error)")
                            }
                        } else {
                            print("error writing file \(tempLocalUrl) : \(error)")
                        }
                    }
                }
                
                print(tempLocalUrl)
                completion()
                
            } else {
                print("Failure: %@", error?.localizedDescription ?? "");
            }
        }
        task.resume()
    }
}



