//
//  ContactUsViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-06-16.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let initialMessage = "How can we help?"
    let placeholderTextColor = UIColor.gray 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        insertPlaceholderText()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        textView.resignFirstResponder()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        
        let issue = Issue(date: Date(), message: textView.text)
        print("Issue Reported by users: \(String(describing: User.current()?.username)), on \(Date()) with message: \(textView.text)")
        
        issue.saveInBackground { (success, error) in
            let successAlert = UIAlertController(title: "Message Sent", message: "Thank you for contacting us, we will reply by email shortly.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            successAlert.addAction(okAction)
            
            if success {
                self.activityIndicator.stopAnimating()
                self.present(successAlert, animated: true, completion: nil)
            } else {
                if error != nil {
                    print("Error occured while attempting to save issue in background: \(error!)") // handle error properly
                }
                
                issue.saveEventually() // can fail silently, check logs
                self.activityIndicator.stopAnimating()
                self.present(successAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Helpers
    private func insertPlaceholderText() {
        DispatchQueue.main.async {
            self.textView.text = self.initialMessage + self.textView.text
            self.textView.textColor = self.placeholderTextColor
        }
    }
    
    private func removePlaceholderText() {
        if let text = textView.text,
            let initialMessageRange = text.range(of: initialMessage) {
            let prefix = text[text.startIndex..<initialMessageRange.lowerBound]
            let suffix = text[initialMessageRange.upperBound..<text.endIndex]
            
            DispatchQueue.main.async {
                self.textView.text = String(prefix) + String(suffix)
            }
        }
    }
    
    
}

extension ContactUsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        removePlaceholderText()
        DispatchQueue.main.async {
            self.textView.textColor = UIColor.black
        }
    }
}
