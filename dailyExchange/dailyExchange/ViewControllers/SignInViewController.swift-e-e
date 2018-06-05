//
//  SignInViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController
{
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func signInButtonTapped(_ sender: Any)
    {
        let validator = UserValidator()
        
        let emailResponse = validator.validateEmail(emailTextField.text)
        let passwordResponse = validator.validatePasswordExists(passwordTextField.text)
        
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            emailResponse.0
        {
            signInButton.isEnabled = false
            activityIndicator.startAnimating()
            
            User.logInWithUsername(inBackground: email, password: password) { (user, error) in
                defer {
                    self.signInButton.isEnabled = true
                    self.activityIndicator.stopAnimating()
                }
                
                guard error == nil else {
                    let alert = UIAlertController(title: "Login failed", message: "Please check your network connection and try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   
                    return
                }
                
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: Notification.Name.didLogIn, object: nil)
            }
            
        } else if let message = passwordResponse.1,
            !passwordResponse.0
        {
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else
        {
            var message = "Email is invalid"
            
            if let emailError = emailResponse.1
            {
                message = emailError
            }
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any)
    {
        self.performSegue(withIdentifier: "unwindToSignUp", sender: self)
    }
    
}
