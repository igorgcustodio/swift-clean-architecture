//
//  SignUpPresenterTests.swift
//  PresentationTests
//
//  Created by Igor Custodio on 25/01/21.
//

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(message: "nome"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(message: "email"))
    }
    
    func test_signup_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(message: "senha"))
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(message: "confirmar senha"))
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(message: "confirmar senha"))
    }
    
    func test_signup_should_show_error_message_if_email_is_invalid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel(email: "invalid_email@mail.com"))
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(message: "email"))
    }
    
    func test_signup_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name", email: String? = "invalid_email@mail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func makeRequiredAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(message) é obrigatório")
    }
    
    func makeInvalidAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(message) é inválido")
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail() {
            self.isValid = false
        }
    }
}
