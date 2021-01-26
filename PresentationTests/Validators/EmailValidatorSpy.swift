//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Igor Custodio on 26/01/21.
//

import Foundation
import Presentation

class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func simulateInvalidEmail() {
        self.isValid = false
    }
}
