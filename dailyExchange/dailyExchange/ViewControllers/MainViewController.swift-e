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
    
    private let fileReader = FileReader()
    private var currencyList: [Currency]?
    private let networkManager = NetworkManager()
    private var numeratorCurrency: Currency?
    private var baseCurrency: Currency?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.exchangeRatesTableView.dataSource = self
        self.exchangeRatesTableView.delegate = self
        
        fileReader.fetchCurrencyListInBackground { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let listWrapper = try jsonDecoder.decode(CurrencyListWrapper.self, from: data)
                self.currencyList = listWrapper.currencies
                
                DispatchQueue.main.async {
                    self.exchangeRatesTableView.reloadData()
                }
            } catch {
                print("\(error)") // TODO look into what error's are thrown here and what can be done 
            }
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reloadForCurrencies(_:)),
                                               name: .didSelectCurrencies,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didSelectCurrencies, object: nil)
    }
    // MARK: - Actions
    
    @IBAction func exchangeRateButtonTapped(_ sender: Any)
    {
        // Display actionsheet that allows user to pic numerator and denominator
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let currencyPicker = mainStoryboard.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
        
        currencyPicker.modalPresentationStyle = .overCurrentContext
        currencyPicker.currencyList = currencyList
        
        present(currencyPicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        // add current Exchange Model to datasource and reload tableView
    }
    
    // MARK: - Notification Methods
    
    @objc func reloadForCurrencies(_ notification: NSNotification) {
        let keys = NotificationKeys.DidSelectCurrencies()
        if let numeratorCurrency = notification.userInfo?[keys.numeratorCurrencyKey] as? Currency,
            let baseCurrency = notification.userInfo?[keys.denominatorCurrencyKey] as? Currency
        {
            networkManager.exchangeRateforCurrency(numeratorCurrency, with: baseCurrency) { exchangeRate in
                DispatchQueue.main.async {
                    self.exchangeRateLabel.text = exchangeRate
                }
            }
            
            exchangeRateButton.setTitle("\(numeratorCurrency.abriviation)/\(baseCurrency.abriviation)",
                for: .normal)
        }
        
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
