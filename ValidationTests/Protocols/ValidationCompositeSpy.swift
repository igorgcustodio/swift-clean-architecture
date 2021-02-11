//
//  ValidationCompositeSpy.swift
//  ValidationTests
//
//  Created by Igor Custodio on 10/02/21.
//

import Foundation
import Presentation

class ValidationCompositeSpy: Validation {
    var errorMessage: String?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
