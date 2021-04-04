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
    @IBOutlet weak var loginButton: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton.layer.cornerRadius = 5
        hideKeyboardOnTap()
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
