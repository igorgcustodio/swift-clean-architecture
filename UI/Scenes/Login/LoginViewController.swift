//
//  SignUpViewController.swift
//  UI
//
//  Created by Igor Custodio on 26/01/21.
//

import UIKit
import Presentation

public final class LoginViewController: UIViewController, Storyboard {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    public var login: ((LoginViewModel) -> Void)?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton.addTarget(self, action: #selector(loginButtonTapper), for: .touchUpInside)
        loginButton.layer.cornerRadius = 5
        hideKeyboardOnTap()
    }
    
    @objc private func loginButtonTapper() {
        let viewModel = LoginViewModel(email: emailTextField.text, password: passwordTextField.text)
        login?(viewModel)
    }
}

extension LoginViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            self.loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            self.loadingIndicator.stopAnimating()
        }
    }
}

extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
