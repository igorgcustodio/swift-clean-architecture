//
//  InfraTests.swift
//  InfraTests
//
//  Created by Igor Custodio on 21/01/21.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_() throws {
        let url = makeUrl()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { (request) in
            XCTAssertEqual(url, request.url)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    open class override func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    open class override func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    
    open override func stopLoading() {}
}
