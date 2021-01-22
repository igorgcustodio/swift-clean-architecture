//
//  AccountModel.swift
//  Domain
//
//  Created by Igor Custodio on 19/01/21.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    public var name: String
    
    public init(accessToken: String, name: String) {
        self.accessToken = accessToken
        self.name = name
    }
}
