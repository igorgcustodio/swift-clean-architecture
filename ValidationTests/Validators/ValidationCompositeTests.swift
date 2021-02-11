//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Igor Custodio on 10/02/21.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    
    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationCompositeSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError("Erro 1")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_should_return_correct_error_message() {
        let validationSpy2 = ValidationCompositeSpy()
        let sut = makeSut(validations: [ValidationCompositeSpy(), validationSpy2])
        validationSpy2.simulateError("Erro 3")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 3")
    }
    
    func test_validate_should_return_first_error_message() {
        let validationSpy2 = ValidationCompositeSpy()
        let validationSpy3 = ValidationCompositeSpy()
        let sut = makeSut(validations: [ValidationCompositeSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError("Erro 2")
        validationSpy3.simulateError("Erro 3")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_nil_if_validation_succeds() {
        let sut = makeSut(validations: [ValidationCompositeSpy(), ValidationCompositeSpy()])
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationCompositeSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "Rodrigo"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [Validation], file: StaticString = #filePath, line: UInt = #line) -> ValidationComposite {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
