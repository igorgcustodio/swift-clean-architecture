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
import Domain

final class ControllerFactory {
    static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidator = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidator, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        
        controller.signUp = presenter.signUp
        
        return controller
    }
}

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    public init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
