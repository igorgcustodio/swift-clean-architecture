//
//  DataTests.swift
//  DataTests
//
//  Created by Igor Custodio on 19/01/21.
//

import XCTest
import Domain
import Data

class RemoteAddAcountTests: XCTestCase {

    func test_add_should_call_http_client_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        
        sut.add(addAcountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_http_client_with_correct_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let addAcountModel = makeAddAccountModel()
        sut.add(addAcountModel: makeAddAccountModel()) { _ in }
        
        XCTAssertEqual(httpClientSpy.data, addAcountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() throws {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAcountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
                break
            case .success:
                XCTFail("Expected error received \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let expectedAccount = makeAccountModel()
        sut.add(addAcountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure:
                XCTFail("Expected success received \(result) instead")
                break
            case .success(let receivedAccount):
                XCTAssertEqual(receivedAccount, expectedAccount)
                break
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
}

// MARK: Helpers
extension RemoteAddAcountTests {
    func makeAddAccountModel() -> AddAcountModel {
        return AddAcountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id", name: "any_name", email: "any_email@mail.com", password: "any_password")
    }
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAcount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAcount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            self.completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            self.completion?(.success(data))
        }
    }
}
