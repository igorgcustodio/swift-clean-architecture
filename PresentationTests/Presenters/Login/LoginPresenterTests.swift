//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Igor Custodio on 01/04/21.
//

import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    
    func test_signup_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_login_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
        }
        validationSpy.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_call_authentication_with_correct_values() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authentication: authenticationSpy)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(authenticationSpy.authenticationModel, makeAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_authentication_fails() {
        let authenticationSpy = AuthenticationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
        }
        
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_expired_session_error_message_if_authentication_completes_with_expired_session() {
        let authenticationSpy = AuthenticationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        
        let exp = expectation(description: "wait")
        
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválidos."))
        }
        
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.expiredSession)
        
        wait(for: [exp], timeout: 1)
    }
}

extension LoginPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), authentication: Authentication = AuthenticationSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation, alertView: alertView, authentication: authentication)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
