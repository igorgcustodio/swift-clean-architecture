//
//  AddAcount.swift
//  Domain
//
//  Created by Igor Custodio on 19/01/21.
//

import Foundation

protocol AddAcount {
    func add(addAcountModel: AddAcountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

struct AddAcountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
