//
//  SignUpComposer.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import UI
import Presentation
import Validation
import Domain


public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(authentication: makeRemoteAuthentication())
}

public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), authentication: authentication, loadingView: WeakVarProxy(controller))
    
    controller.login = presenter.login
    
    return controller
}

public func makeLoginValidations() -> [Validation] {
    return [
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
    ]
}
