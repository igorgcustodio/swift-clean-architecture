//
//  SignUpPresentation.swift
//  Presentation
//
//  Created by Igor Custodio on 25/01/21.
//

import Foundation
import Domain

public final class LoginPresenter {
    
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication) {
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            self.authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { _ in
                
            }
        }
    }
}
