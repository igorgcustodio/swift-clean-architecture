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

class AddAcountIntegrationTests: XCTestCase {
    
    func test_add_acount() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let sut = RemoteAddAcount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Rodrigo Manguinho", email: "rodrigo.manguinho@gmail.comm", password: "secret", passwordConfirmation: "secret")
        
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success, got \(result)")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, addAccountModel.name)
                XCTAssertEqual(account.email, addAccountModel.email)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
    }
}
