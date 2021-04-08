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


public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instantiate()
    controller.signUp = router.goToSignUp
    controller.login = router.goToLogin
    
    return controller
}
