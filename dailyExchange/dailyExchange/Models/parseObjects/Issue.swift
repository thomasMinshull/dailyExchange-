//
//  Issue.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-06-17.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse

class Issue: PFObject, PFSubclassing {
    @NSManaged var user: User!
    @NSManaged var date: Date
    @NSManaged var message: String
    
    static func parseClassName() -> String {
        return "Issue"
    }
    
    convenience init(date: Date, message: String, user: User! = User.current()!) {
        self.init()
        self.user = user
        self.date = date
        self.message = message
    }
}
