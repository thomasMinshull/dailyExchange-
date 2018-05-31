//
//  FileReader.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-04-13.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class FileReader: NSObject {
    func fetchCurrencyListInBackground(completionHandler: (Data) -> ()) {
        guard let currencyListFileURL = CurrencyJsonMapping.filePathForCurrencyList() else {
            fatalError("Unable to unwrap currency List URL")
        }
        do {
            let currencyListFileData = try Data.init(contentsOf: currencyListFileURL)
            completionHandler(currencyListFileData)
        } catch {
            let unaccesibleCurrencyList = UnaccesibleCurrencyListError()
            ErrorPrecentor(error: unaccesibleCurrencyList).pressentAlertWith(actions: [UIAlertAction]())
        }
    }
}
