//
//  DataTests.swift
//  DataTests
//
//  Created by Igor Custodio on 19/01/21.
//

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {

    func test_add_should_call_http_client_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        
        sut.auth(authenticationModel: makeAuthenticationModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_http_client_with_correct_data()  {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel)
        
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }
}

// MARK: Helpers
extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
}
