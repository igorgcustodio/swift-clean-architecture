//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Igor Custodio on 26/01/21.
//

import Foundation
import Domain

class AuthenticationSpy: Authentication {
    
    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?
    
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        completion?(.success(account))
    }
}
