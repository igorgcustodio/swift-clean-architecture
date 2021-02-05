//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Igor Custodio on 04/02/21.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
}
