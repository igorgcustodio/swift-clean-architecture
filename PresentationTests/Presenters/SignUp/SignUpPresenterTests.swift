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
    
    func test_signup_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signup_should_show_generic_error_message_if_addAccount_fails() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_email_in_use_error_message_if_addAccount_returns_email_in_use_error() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse email já está em uso"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.emailInUse)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_success_message_if_addAccount_succeeds() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
        }
        
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        
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
    
    func test_signup_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signup_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
