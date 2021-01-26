//
//  EmailValidator.swift
//  Presentation
//
//  Created by Igor Custodio on 25/01/21.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
