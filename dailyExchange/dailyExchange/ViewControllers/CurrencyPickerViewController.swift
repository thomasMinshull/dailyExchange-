//
//  CurrencyPickerViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-21.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currencyList: [Currency]?
    private let currencyCellID = CurrencyTableViewCell().reuseIdentifier!
    
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var numeratorTableView: UITableView!
    @IBOutlet var denominatorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numeratorTableView.delegate = self
        numeratorTableView.dataSource = self
        denominatorTableView.delegate = self
        denominatorTableView.dataSource = self
        
        let cellNib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        
        numeratorTableView.register(cellNib, forCellReuseIdentifier: currencyCellID)
        denominatorTableView.register(cellNib, forCellReuseIdentifier: currencyCellID)
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let currencyList = currencyList else {
            return
        }
        if let denominatorIndexPath = denominatorTableView.indexPathForSelectedRow,
            let numeratorIndexPath = numeratorTableView.indexPathForSelectedRow
        {
            let denominatoryCurrency = currencyList[denominatorIndexPath.row]
            let numeratorCurrency = currencyList[numeratorIndexPath.row]
            
            //TODO: - post notification updateing selected currency
            
        } else {
            let alert = UIAlertController(title: "Select 2 currencies to compair",
                                          message: nil,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            alert.addAction(action)
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
    }
    
    // MARK: - tableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellID) as? CurrencyTableViewCell
        
        if let currencyList = currencyList,
            let cell = cell
        {
            cell.setUpWith(currency: currencyList[indexPath.row])
        }
        return cell!
    }
    
    // MARK: - TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currencyList = currencyList,
            let currencyLabel = currencyLabel else {
                return
        }
        
        let selectedCurrency = currencyList[indexPath.row]
        var currencyLabelTextComponenets = currencyLabel.text?.components(separatedBy: "/")
        
        if tableView == numeratorTableView! {
            currencyLabelTextComponenets?[0] = selectedCurrency.abriviation
        } else {
            currencyLabelTextComponenets?[1] = selectedCurrency.abriviation
        }
        
        currencyLabel.text = "\(currencyLabelTextComponenets![0])/\(currencyLabelTextComponenets![1])"
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let currencyLabel = currencyLabel else {
            return
        }
        
        var currencyLabelTextComponenets = currencyLabel.text?.components(separatedBy: "/")
        
        if tableView == numeratorTableView! {
            currencyLabelTextComponenets?[0] = "$"
        } else {
            currencyLabelTextComponenets?[1] = "$"
        }
        
        currencyLabel.text = "\(currencyLabelTextComponenets![0])/\(currencyLabelTextComponenets![1])"
    }
}
