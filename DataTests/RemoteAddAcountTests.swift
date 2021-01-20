//
//  DataTests.swift
//  DataTests
//
//  Created by Igor Custodio on 19/01/21.
//

import XCTest
import Domain

class RemoteAddAcount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAcountModel: AddAcountModel) {
        let data = try? JSONEncoder().encode(addAcountModel)
        httpClient.post(to: self.url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAcountTests: XCTestCase {

    func test_add_should_call_http_client_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        
        let sut = RemoteAddAcount(url: url, httpClient: httpClientSpy)
        
        sut.add(addAcountModel: makeAddAccountModel())
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_http_client_with_correct_data() throws {
        
        let httpClientSpy = HttpClientSpy()
        
        let sut = RemoteAddAcount(url: URL(string: "http://any-url.com")!, httpClient: httpClientSpy)
        let addAcountModel = makeAddAccountModel()
        sut.add(addAcountModel: makeAddAccountModel())
        
        let data = try? JSONEncoder().encode(addAcountModel)
        
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

// MARK: Helpers
extension RemoteAddAcountTests {
    func makeAddAccountModel() -> AddAcountModel {
        return AddAcountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
    }
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
