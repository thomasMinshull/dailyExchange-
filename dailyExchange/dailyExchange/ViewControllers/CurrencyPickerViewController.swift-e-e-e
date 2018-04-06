//
//  CurrencyPickerViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-21.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var currencyList: [Currency]?
    private let currencyCellID = CurrencyTableViewCell().reuseIdentifier!
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var numeratorTableView: UITableView!
    @IBOutlet var denominatorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates
        numeratorTableView.delegate = self
        numeratorTableView.dataSource = self
        denominatorTableView.delegate = self
        denominatorTableView.dataSource = self
        searchBar.delegate = self
        
        // resgister cells
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
            let numeratorIndexPath = numeratorTableView.indexPathForSelectedRow,
            denominatorIndexPath != numeratorIndexPath
        {
            let keys = NotificationKeys.DidSelectCurrencies()
        
            let currencyDictionary = [
                keys.denominatorCurrencyKey: currencyList[denominatorIndexPath.row],
                keys.numeratorCurrencyKey: currencyList[numeratorIndexPath.row]
            ]
            
            NotificationCenter.default.post(name: .didSelectCurrencies,
                                            object: nil,
                                            userInfo: currencyDictionary)
            
            dismiss(animated: true, completion: nil)
            
        } else if let denominatorIndexPath = denominatorTableView.indexPathForSelectedRow,
            let numeratorIndexPath = numeratorTableView.indexPathForSelectedRow,
            denominatorIndexPath == numeratorIndexPath
        {
            let alert = UIAlertController(title: "Select 2 different currencies to compair",
                                          message: nil,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            alert.addAction(action)
            self.present(alert,
                         animated: true,
                         completion: nil)
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
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - SearchBarDelegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0  else {
            return
        }
        
        if let index = currencyList?.index(where: {
            (currency) -> Bool in
            return currency.abriviation.contains(searchText) ||
                currency.fullName.contains(searchText)
        }) {
            let selectedTableview = searchBar.selectedScopeButtonIndex == 1 ? denominatorTableView : numeratorTableView
            let indexPath = IndexPath(row: index, section: 0)
            selectedTableview?.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard selectedScope < 2 else {
            return
        }
        
        searchBar.text = ""
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
