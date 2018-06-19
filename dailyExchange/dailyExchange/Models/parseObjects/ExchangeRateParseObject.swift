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
    @NSManaged var user: PFUser?
    @NSManaged var isSavedOnServer: Bool
    
    private let channelsKey = "channels"
    private var notificationKey: String {
        return numberatorCurrencyAbriviation + denominatorCurrencyAbriviation
    }
    
    static func parseClassName() -> String {
        return "ExchangeRateParseObject"
    }
    
    convenience init(jsonMapping: ExchangeRateJsonMapping) {
        self.init()
        timestamp = jsonMapping.timestamp
        numberatorCurrencyAbriviation = jsonMapping.numberatorCurrencyAbriviation
        denominatorCurrencyAbriviation = jsonMapping.denominatorCurrencyAbriviation
        rate = jsonMapping.rate
        isSavedOnServer = false
    }
    
    func isNotificationEnabled(_ installation: PFInstallation? = PFInstallation.current()) -> Bool {
        guard let channels = installation?.object(forKey: channelsKey) as? [String] else {
            return false
        }
        return channels.contains(notificationKey)
    }
    
    func enableNotification(_ installation: PFInstallation? = PFInstallation.current()) {
        installation?.addUniqueObject(notificationKey, forKey: channelsKey)
        installation?.saveInBackground(block: { (success, error) in
            if error != nil || !success {
                installation?.saveEventually()
            }
        })
    }
    
    func disableNotification(_ installation: PFInstallation? = PFInstallation.current()) {
        installation?.remove(notificationKey, forKey: channelsKey)
        installation?.saveInBackground(block: { (success, error) in
            if error != nil || !success {
                installation?.saveEventually()
            }
        })
    }
}
