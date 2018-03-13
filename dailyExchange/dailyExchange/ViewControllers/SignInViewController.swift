//
//  SignInViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let validator = UserValidator()
        
        let emailResponse = validator.validateEmail(emailTextField.text)
        let passwordResponse = validator.validatePasswordExists(passwordTextField.text)
        
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            emailResponse.0 {
            
            do {
                try User.logIn(withUsername: email, password: password)
            } catch {
                let alert = UIAlertController(title: "Login failed", message: "Please check your network connection and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else if let message = passwordResponse.1,
            !passwordResponse.0 {
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            var message = "Email is invalid"
            
            if let emailError = emailResponse.1 {
                message = emailError
            }
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToSignUp", sender: self)
    }
    
}
