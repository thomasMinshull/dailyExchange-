//
//  ExchangeRateTableViewCell.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-13.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    @IBOutlet var numeratorLabel: UILabel!
    @IBOutlet var denominatorLabel: UILabel!
    @IBOutlet var notificationSwitch: UISwitch!
    
    func configure(with exchangeRate: ExchangeRateParseObject) {
        numeratorLabel.text = exchangeRate.numberatorCurrencyAbriviation
        denominatorLabel.text = exchangeRate.denominatorCurrencyAbriviation
        // notificationSwitch.isOn = exchangeRate.shouldHaveSomeValueHereToToggle // ToDo 
    }
    
    @IBAction func notificationSwitchToggled(_ sender: Any) {
        
    }
}
