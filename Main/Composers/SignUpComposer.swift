//
//  SignUpComposer.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}
