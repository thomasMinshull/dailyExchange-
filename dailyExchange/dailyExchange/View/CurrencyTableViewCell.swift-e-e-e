//
//  CurrencyTableViewCell.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-21.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet var abriviationLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    
    override var reuseIdentifier: String? {
        return "CurrencyTableViewCell"
    }
    
    func setUpWith(currency: CurrencyJsonMapping) {
        abriviationLabel?.text = currency.abriviation
        fullNameLabel?.text = currency.fullName
    }
}
