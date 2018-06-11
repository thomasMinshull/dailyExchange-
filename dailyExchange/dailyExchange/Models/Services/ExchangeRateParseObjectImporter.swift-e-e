//
//  ExchangeRateParseObjectImporter.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-06-11.
//  Copyright © 2018 thomas minshull. All rights reserved.

import Parse

/// The Class Manages the fetching an mergering of ExchangeRateParseObjects from
/// the local store and the parse backend. It does this work asyncronously using the bolts framework 
class ExchangeRateParseObjectImporter {
    private var serverExchangeRateParseObjects = [ExchangeRateParseObject]()
    private var localStoreExchangeRateParseObjects = [ExchangeRateParseObject]()
    
    func fetchExchangeRateParseObjectsWithCompletion(completionBlock: @escaping ([ExchangeRateParseObject]) -> ()) {
        // returns a task that will populate serverExchangeRateParseObjects array with data from the server
        let serverTask = fetchExchangeRateParseObjectsFromServer()
        // retruns a task that will populate localStorageExchangeRateParseObjects with data from the local store
        let localStoreTask = fetchExchangeRateParseObjectsFromLocalStore()
        let _ = BFTask(forCompletionOfAllTasks: [serverTask, localStoreTask]).continueWith {
            (task: BFTask<AnyObject>) -> BFTask<AnyObject>? in
            
            // If we don't get data from the server use local store copy
            guard self.serverExchangeRateParseObjects.count > 0 else {
                completionBlock(self.localStoreExchangeRateParseObjects)
                return BFTask(result: nil)
            }
            
            // If we do get data from the server merge in the locallyEdited Exchange rates
            let locallyEditedExchangeRateParseObjects = self.serverExchangeRateParseObjects.filter{
                return $0.isSavedOnServer == false
            }
            
            for locallyEditedExchangeRate in locallyEditedExchangeRateParseObjects {
                if let index = self.serverExchangeRateParseObjects.index(where: { (serverExchangeRate) -> Bool in
                    return locallyEditedExchangeRate.denominatorCurrencyAbriviation == serverExchangeRate.denominatorCurrencyAbriviation && locallyEditedExchangeRate.numberatorCurrencyAbriviation == serverExchangeRate.numberatorCurrencyAbriviation
                }) {
                    self.serverExchangeRateParseObjects[index] = locallyEditedExchangeRate
                }
            }
            
            // save anything that is still in the server that is not in the local store
            for serverExchangeRate in self.serverExchangeRateParseObjects {
                if !self.localStoreExchangeRateParseObjects.contains(serverExchangeRate) {
                    serverExchangeRate.pinInBackground()
                }
            }
            
            completionBlock(self.serverExchangeRateParseObjects)
            return BFTask(result: nil)
        }
    }
    
    private func fetchExchangeRateParseObjectsFromServer() -> BFTask<AnyObject> {
        // query server for ExchangeRateParseObjects
        let query = ExchangeRateParseObject.query()!
        query.whereKey("user", equalTo: PFUser.current()!) // ToDo create a method to log user out of app if PFUser.current() is nil
        return query.findObjectsInBackground().continueWith { (task) -> BFTask<AnyObject>? in
            guard task.error == nil else {
                print("An error occured fetching from local store; \(task.error!)")
                return BFTask(error: DefaultError()) // ToDo handle error path properly
            }
            
            guard let exchangeRates = task.result as?  [ExchangeRateParseObject] else {
                print("Unable to fetch an aray of ExchangeRateParseObjects from local store")
                return BFTask(error: DefaultError()) // ToDo handle error path properly
            }
            
            let array = exchangeRates as NSArray
            
            return BFTask(result: array)
            }.continueWith { (task) -> BFTask<AnyObject> in
                guard var exchangeRates = task.result as? [ExchangeRateParseObject] else {
                    return BFTask(error: DefaultError())
                }
                
                exchangeRates = exchangeRates.map{
                    $0.isSavedOnServer = true
                    return $0
                }
                
                self.serverExchangeRateParseObjects = exchangeRates
                
                return BFTask(result: nil)
            } as BFTask<AnyObject>
    }
    
    private func fetchExchangeRateParseObjectsFromLocalStore() -> BFTask<AnyObject> {
        let localStoreQuery = ExchangeRateParseObject.query()!
        localStoreQuery.fromLocalDatastore()
        return localStoreQuery.findObjectsInBackground().continueOnSuccessWith { (task) -> Any? in
            self.localStoreExchangeRateParseObjects = task.result as! [ExchangeRateParseObject]
        }
    }
}
