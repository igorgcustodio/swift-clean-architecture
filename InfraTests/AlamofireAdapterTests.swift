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
    
    func post(to url: URL, with data: Data?) {
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_post_should_make_request_with_valid_urland_method() throws {
        let url = makeUrl()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url, with: makeValidData())
        
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
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
