//
//  SignUpPresenterTests.swift
//  PresentationTests
//
//  Created by Igor Custodio on 25/01/21.
//

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(message: "nome"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(message: "email"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(message: "senha"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(message: "confirmar senha"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(message: "confirmar senha"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_email_is_invalid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(message: "email"))
        }
        
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel(email: "invalid_email@mail.com"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signup_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signup_should_show_error_message_if_addAccount_fails() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_loading_before_and_after_call_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        
        let exp = expectation(description: "wait")
        loadingViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "wait")
        loadingViewSpy.observe { viewModel in
            exp2.fulfill()
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
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
    
    class AlertViewSpy: AlertView {
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
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
    
    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
    
    class LoadingViewSpy: LoadingView {
        
        var emit: ((LoadingViewModel) -> Void)?
        
        func observe(completion: @escaping (LoadingViewModel) -> Void) {
            self.emit = completion
        }
        
        func display(viewModel: LoadingViewModel) {
            emit?(viewModel)
        }
    }
}
