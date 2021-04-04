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
    public var signUp: (() -> Void)?
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        login?()
    }
    
    @objc private func signUpButtonTapped() {
        signUp?()
    }
}
