//
//  SignUpViewController.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController
{
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let validator = UserValidator()
        
        let emailResponse = validator.validateEmail(emailTextField.text)
        let passwordResponse = validator.validatePassword(passwordTextField.text)
        
        if emailResponse.0 && passwordResponse.0
        {
            let user = User()
            user.username = emailTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground(block: { (success, error) in
                if let error = error
                {
                    let errorMessage:String = error.localizedDescription
                    let alert = UIAlertController(title: "Sign up failed", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else
                {
                    let notificationCenter = NotificationCenter.default
                    notificationCenter.post(name: Notification.Name.didLogIn, object: nil)
                }
            })
            
        } else
        {
            var message = "Email or Password is invalid"
            
            if let passwordError = passwordResponse.1
            {
                message = passwordError
            }
            
            if let emailError = emailResponse.1
            {
                message = emailError
            }
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSignUp(segue:UIStoryboardSegue) { }

}
