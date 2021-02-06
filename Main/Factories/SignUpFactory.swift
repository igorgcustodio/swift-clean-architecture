//
//  SignUpFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidator = EmailValidatorAdapter()
        let url = URL(string: "http://localhost:5050/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let remoteAddAccount = RemoteAddAcount(url: url, httpClient: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: controller, emailValidator: emailValidator, addAccount: remoteAddAccount, loadingView: controller)
        
        controller.signUp = presenter.signUp
        
        return controller
    }
}
