//
//  Validation.swift
//  Presentation
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
