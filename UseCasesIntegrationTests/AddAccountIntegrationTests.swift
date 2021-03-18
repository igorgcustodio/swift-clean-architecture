//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Igor Custodio on 21/01/21.
//

import XCTest
import Domain
import Data
import Infra

class AddAccountIntegrationTests: XCTestCase {
    
    func test_add_acount() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://localhost:5050/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Rodrigo Manguinho", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
        
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success, got \(result)")
            case .success(let account):
                XCTAssertEqual(account.name, addAccountModel.name)
                XCTAssertNotNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let exp2 = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error) where error == .emailInUse:
                XCTAssertNotNil(error)
            default:
                XCTFail("Expect failure, got \(result)")
            }
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 5)
    }
}
