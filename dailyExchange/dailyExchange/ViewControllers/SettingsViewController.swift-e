//
//  SettingsViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        PFUser.logOut()
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name.didLogout, object: nil)
    }
}
