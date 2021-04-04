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
