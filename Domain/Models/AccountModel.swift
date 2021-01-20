//
//  AccountModel.swift
//  Domain
//
//  Created by Igor Custodio on 19/01/21.
//

import Foundation

public struct AccountModel {
    public var id: String
    public var name: String
    public var email: String
    public var password: String
    
    public init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
