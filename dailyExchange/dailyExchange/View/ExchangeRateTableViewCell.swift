//
//  ExchangeRateTableViewCell.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-13.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse

protocol ExchangeRateCellProtocol: class {
    func notificationSwitchDidToggleFor(cell: ExchangeRateTableViewCell, installation: PFInstallation?)
}

class ExchangeRateTableViewCell: UITableViewCell {
    weak var delegate: ExchangeRateCellProtocol?
    @IBOutlet var numeratorLabel: UILabel!
    @IBOutlet var denominatorLabel: UILabel!
    @IBOutlet var notificationSwitch: UISwitch!
    
    func configure(with exchangeRate: ExchangeRateParseObject) {
        numeratorLabel.text = exchangeRate.numberatorCurrencyAbriviation
        denominatorLabel.text = exchangeRate.denominatorCurrencyAbriviation
        notificationSwitch.isOn = exchangeRate.isNotificationEnabled()
    }
    
    @IBAction func notificationSwitchToggled(_ sender: Any) {
        if let delegate = delegate {
            delegate.notificationSwitchDidToggleFor(cell: self, installation: PFInstallation.current())
        }
    }
}
