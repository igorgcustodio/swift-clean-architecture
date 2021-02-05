//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Igor Custodio on 04/02/21.
//

import Foundation
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public init() {
    }
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
