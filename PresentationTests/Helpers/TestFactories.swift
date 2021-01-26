//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Igor Custodio on 26/01/21.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeRequiredAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(message) é obrigatório")
}

func makeInvalidAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(message) é inválido")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}
