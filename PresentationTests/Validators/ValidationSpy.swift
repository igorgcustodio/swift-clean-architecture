//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Presentation

public class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    public func validate(data: [String: Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError() {
        self.errorMessage = "Erro"
    }
}

