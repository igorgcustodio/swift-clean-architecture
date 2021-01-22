//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Igor Custodio on 21/01/21.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "any_token", name: "any_name")
}
