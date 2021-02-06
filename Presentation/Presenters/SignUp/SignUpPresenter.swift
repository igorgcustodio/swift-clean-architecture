//
//  SignUpPresentation.swift
//  Presentation
//
//  Created by Igor Custodio on 25/01/21.
//

import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView) {
        self.emailValidator = emailValidator
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: true))
                switch result {
                case .failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
                }
            }
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O campo nome é obrigatório"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo email é obrigatório"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo senha é obrigatório"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "O campo confirmar senha é obrigatório"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "O campo confirmar senha é inválido"
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "O campo email é inválido"
        }
        return nil
    }
}
