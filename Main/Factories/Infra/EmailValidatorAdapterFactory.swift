//
//  UseCaseFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Infra

func makeEmailValidatorAdapter() -> EmailValidatorAdapter {
    return EmailValidatorAdapter()
}
