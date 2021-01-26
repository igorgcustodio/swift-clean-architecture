//
//  SignUpPresentation.swift
//  Presentation
//
//  Created by Igor Custodio on 25/01/21.
//

import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.emailValidator = emailValidator
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "Nome é obrigatório"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "Email é obrigatório"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "Senha é obrigatória"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "Confirmar senha é obrigatório"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "Falha ao confirmar senha"
        } else {
            _ = emailValidator.isValid(email: viewModel.email!)
            return nil
        }
    }
}

public struct SignUpViewModel {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init (name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
