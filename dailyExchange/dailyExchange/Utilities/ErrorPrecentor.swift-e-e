//
//  ErrorPrecentor.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-04-02.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

protocol PresentableError {
    var errorTitle: String { get }
    var errorMessage: String? { get }
}

// MARK: - Presentable Errors

struct DefaultError: Error, PresentableError {
    let errorTitle = "An Unknown Error Occured"
    let errorMessage: String? = nil
}

struct UnaccesibleCurrencyListError: Error, PresentableError {
    let errorTitle = "Currency List Error"
    let errorMessage: String? = "We are currently unable to access the list of avalible currencies. You may need to update the app."
}

// MARK: - PresentableErrors for NSErrors

struct NSURLErrorSecureConnectionFailed: PresentableError {
    let errorTitle = "Network Connection Failed"
    let errorMessage: String? = "Please check your internet connection and try again."
}

struct NSURLErrorConnectionFailed: PresentableError {
    let errorTitle = "Network Connection Failed"
    let errorMessage: String? = "Please check your internet connection and try again."
}

// MARK: - ErrorPracentor Class

class ErrorPrecentor: NSObject {
    static func presentableErrorFor(_ error: Error) -> PresentableError {
        switch error {
        case is PresentableError:
            return error as! PresentableError
        case URLError.notConnectedToInternet:
            return NSURLErrorConnectionFailed()
        default:
            return DefaultError()
        }
    }
    
    private let errorUI: PresentableError
    
    init(error: Error) {
        self.errorUI = ErrorPrecentor.presentableErrorFor(error)
        
    }
    
    func pressentAlertWith(actions: [UIAlertAction],
                                 from viewController: UIViewController = UIApplication.shared.delegate!.window!!.rootViewController!.visibleViewController()!
    ) {
        let alert = UIAlertController(title: errorUI.errorTitle, message: errorUI.errorMessage, preferredStyle: .alert)
        
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
