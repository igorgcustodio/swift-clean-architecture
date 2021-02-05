//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Igor Custodio on 04/02/21.
//

import XCTest
import Validation

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "igor@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "igor@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "igor@hotmail.com.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
