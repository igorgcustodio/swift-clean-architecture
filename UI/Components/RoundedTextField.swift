//
//  RoundedTextField.swift
//  UI
//
//  Created by Igor Custodio on 17/03/21.
//

import UIKit

public final class RoundedTextField: UITextField {
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.borderColor = Color.primaryLight.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
}
