//
//  DataTests.swift
//  DataTests
//
//  Created by Igor Custodio on 19/01/21.
//

import XCTest

class RemoteAddAcount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: self.url)
    }
}

protocol HttpPostClient {
    func post(url: URL)
}

class RemoteAddAcountTests: XCTestCase {

    func test_() throws {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        
        let sut = RemoteAddAcount(url: url, httpClient: httpClientSpy)
        sut.add()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
