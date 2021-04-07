//
//  SceneDelegate.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let signUpFactory: () -> SignUpViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let remoteAddAccount = makeRemoteAddAccount(httpClient: alamofireAdapter)
        return makeSignUpController(addAccount: remoteAddAccount)
    }
    
    private let loginFactory: () -> LoginViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let remoteAuthentication = makeRemoteAuthentication(httpClient: alamofireAdapter)
        return makeLoginController(authentication: remoteAuthentication)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let nav = NavigationController()
        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let welcomeViewController = WelcomeViewController.instantiate()
        welcomeViewController.signUp = welcomeRouter.goToSignUp
        welcomeViewController.login = welcomeRouter.goToLogin
        
        nav.setRootViewController(welcomeViewController)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

