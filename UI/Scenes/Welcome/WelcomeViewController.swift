//
//  WelcomeViewController.swift
//  UI
//
//  Created by Igor Custodio on 04/04/21.
//

import UIKit

class WelcomeViewController: UIViewController, Storyboard {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    public var login: (() -> Void)?
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func loginButtonTapped() {
        login?()
    }
}

// PAROU EM 15:08
