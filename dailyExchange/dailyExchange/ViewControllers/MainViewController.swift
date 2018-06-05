//
//  MainViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var exchangeRateLabel: UILabel!
    @IBOutlet var exchangeRateButton: UIButton!
    @IBOutlet var exchangeRatesTableView: UITableView!
    @IBOutlet var saveButton: UIButton!
    
    private let fileReader = FileReader()
    private var currencyList: [CurrencyJsonMapping]?
    private let networkManager = NetworkManager()
    
    
    private var exchangeRates = [ExchangeRateParseObject]()
    private var exchangeRate: ExchangeRateParseObject? {
        didSet {
            guard let exchangeRate = exchangeRate else {
                DispatchQueue.main.async {
                    self.saveButton?.isEnabled = false
                    self.exchangeRateButton?.setTitle("$/Base",
                        for: .normal)
                    self.exchangeRateLabel?.text = "0.00"
                }
                return
            }
            
            // update UI
            DispatchQueue.main.async {
                self.saveButton?.isEnabled = !self.exchangeRates.contains(where: { (savedExchangeRate) -> Bool in
                    return savedExchangeRate.denominatorCurrencyAbriviation == exchangeRate.denominatorCurrencyAbriviation &&
                    savedExchangeRate.numberatorCurrencyAbriviation == exchangeRate.numberatorCurrencyAbriviation
                })
                
                self.exchangeRateButton?.setTitle("\(exchangeRate.numberatorCurrencyAbriviation) / \(exchangeRate.denominatorCurrencyAbriviation)",
                    for: .normal)
                
                // ToDo the number of decimal places should be a function of the base currency // https://stackoverflow.com/questions/2701301/various-countrys-currency-decimal-places-width-in-the-iphone-sdk

                let formatedRate = String(format: "%.2f", exchangeRate.rate)
                self.exchangeRateLabel?.text = formatedRate
            }
        }
    }

    // MARK: - LifeCycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.exchangeRatesTableView.dataSource = self
        self.exchangeRatesTableView.delegate = self
        
        fileReader.fetchCurrencyListInBackground { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let listWrapper = try jsonDecoder.decode(CurrencyListJsonMapping.self, from: data)
                self.currencyList = listWrapper.currencies
                
                DispatchQueue.main.async {
                    self.exchangeRatesTableView.reloadData()
                }
            } catch {
                print("\(error)") // TODO look into what error's are thrown here and what can be done 
            }
        }
        
        let query = ExchangeRateParseObject.query()!
        query.fromLocalDatastore()
        query.findObjectsInBackground().continueWith { (task) -> Any? in
            guard task.error == nil else {
                print("An error occured fetching from local store; \(task.error!)")
                return nil 
            }
            
            guard let exchangeRates = task.result as?  [ExchangeRateParseObject] else {
                 print("Unable to fetch an aray of ExchangeRateParseObjects from local store")
                return nil
            }
            
            DispatchQueue.main.async {
                self.exchangeRates = exchangeRates
                self.exchangeRatesTableView.reloadData()
            }
            
            return nil
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
        if let exchangeRate = exchangeRate {
            self.saveButton.isEnabled = false
            
            exchangeRate.saveEventually { (success, error) in
                guard success else {
                    print("An error occured while saving exchangeRate: \(error!)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.exchangeRates.append(exchangeRate)
                    self.exchangeRatesTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Notification Methods
    
    @objc func reloadForCurrencies(_ notification: NSNotification) {
        let keys = NotificationKeys.DidSelectCurrencies()
        if let numeratorCurrency = notification.userInfo?[keys.numeratorCurrencyKey] as? CurrencyJsonMapping,
            let baseCurrency = notification.userInfo?[keys.denominatorCurrencyKey] as? CurrencyJsonMapping
        {
            networkManager.exchangeRateforCurrency(numeratorCurrency, with: baseCurrency) { exchangeRate in
                self.exchangeRate = exchangeRate
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateTableViewCell", for: indexPath) as? ExchangeRateTableViewCell
        
        cell?.delegate = self
        cell?.configure(with: exchangeRates[indexPath.row])
        return cell!
    }
}

extension MainViewController: ExchangeRateCellProtocol {
    func notificationSwitchDidToggleFor(cell: ExchangeRateTableViewCell) {
        if let indexPath = self.exchangeRatesTableView.indexPath(for: cell as UITableViewCell),
            indexPath.row > 0 && indexPath.row < exchangeRates.count
        {
            let exchangeRate = exchangeRates[(indexPath.row)]
            exchangeRate.notificationsEnabled = !exchangeRate.notificationsEnabled
            exchangeRate.saveEventually { (success, error) in
                if let error = error {
                    print("Error occured when updatingNotificationsEnabled for exchangeRate, error: \(error)")
                }
                if success {
                    print("Successfully updated notificationEnabled Status")
                    self.exchangeRatesTableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    exchangeRate.notificationsEnabled = !exchangeRate.notificationsEnabled
                    self.exchangeRatesTableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
    }
    
    
}
