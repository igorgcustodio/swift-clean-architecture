//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Igor Custodio on 06/02/21.
//

import XCTest
import Main

class SignUpComposerTests: XCTestCase {

    func test_ui_presentation_integration() {
        let sut = SignUpComposer.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
