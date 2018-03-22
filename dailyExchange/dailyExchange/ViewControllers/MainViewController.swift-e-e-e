//
//  MainViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var exchangeRateLabel: UILabel!
    @IBOutlet var exchangeRateButton: UIButton!
    @IBOutlet var exchangeRatesTableView: UITableView!
    
    private let currencyParser = CurrencyXMLParser()
    private let networkManager = NetworkManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.exchangeRatesTableView.dataSource = self
        self.exchangeRatesTableView.delegate = self
        currencyParser.retreveCurrencyList(from: Currency.filePathForCurrencySchema()) {
            (currencyList) in
            print(currencyList)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reloadForCurrencies(_:)),
                                               name: .didSelectCurrencies,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didSelectCurrencies, object: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func exchangeRateButtonTapped(_ sender: Any)
    {
        // Display actionsheet that allows user to pic numerator and denominator
        
        //TODO: - present currencyPickerVC
    }
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        // add current Exchange Model to datasource and reload tableView
    }
    
    // MARK: - Notification Methods
    
    @objc func reloadForCurrencies(_ notification: NSNotification) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1 // temp value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateTableViewCell", for: indexPath)
        return cell
    }

}
