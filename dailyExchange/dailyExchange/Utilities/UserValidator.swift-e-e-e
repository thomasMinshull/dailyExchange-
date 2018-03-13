//
//  UserValidator.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class UserValidator: NSObject
{
    func validateEmail(_ email: String?) -> (Bool, String?)
    {
        guard var email = email else
        {
            return (false, "Email cannot be blank.")
        }
        
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard email.count > 0 else
        {
            return (false, "Email cannot be blank.")
        }
        
        guard email.contains("@") else
        {
            return (false, "Email must contain an @ symbol")
        }
        
        return (true, nil)
    }
    
    func validatePasswordExists(_ password: String?) -> (Bool, String?) {
        guard var password = password else
        {
            return (false, "Password cannot be blank")
        }
        
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if password == ""
        {
            return (false, "Password cannot be blank")
        } else {
            return (true, nil)
        }
    }
    
    func validatePassword(_ password: String?) -> (Bool, String?)
    {
        guard var password = password else
        {
            return (false, "Password cannot be blank")
        }
        
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard password.count > 5 else
        {
            return (false, "Password must be at least 6 characters long")
        }
        
        let symbolRegex = ".*[!&^%$#@()]+.*"
        guard input(password, matches: symbolRegex) else
        {
            return (false, "Password must contain at least one symbol")
        }
        
        let capitalLetterRegex = ".*[A-Z]+.*"
        guard input(password, matches: capitalLetterRegex) else
        {
            return (false, "Password must contain at least one capital letter")
        }
        
        let lowercaseRegex = ".*[a-z]+.*"
        guard input(password, matches: lowercaseRegex) else
        {
            return (false, "Password must contain at least one lowercase letter")
        }
        
        return (true, nil)
    }
    
    private func input(_ input: String, matches regex: String) -> Bool
    {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}
