//
//  UITests.swift
//  UITests
//
//  Created by Igor Custodio on 26/01/21.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class LoginViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_loginButton_calls_login_on_tap() {
        var loginViewModel: LoginViewModel?
        let sut = makeSut(loginSpy: { loginViewModel = $0})
        sut.loginButton?.simulateTap()
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        XCTAssertEqual(loginViewModel, LoginViewModel(email: email, password: password))
    }
}

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
