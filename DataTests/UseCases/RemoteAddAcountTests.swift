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
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_valid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account)) {
            httpClientSpy.completeWithData(account.toData()!)
        }
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(Data("invalid_data".utf8))
        }
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
    
    func expect(_ sut: RemoteAddAcount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void) {
        let exp = expectation(description: "waiting")
        sut.add(addAcountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default:
                XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
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
