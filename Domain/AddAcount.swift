//
//  AddAcount.swift
//  Domain
//
//  Created by Igor Custodio on 19/01/21.
//

import Foundation

public protocol AddAcount {
    func add(addAcountModel: AddAcountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

public struct AddAcountModel: Codable {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
