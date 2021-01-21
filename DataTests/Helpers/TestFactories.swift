//
//  TestFactories.swift
//  DataTests
//
//  Created by Igor Custodio on 21/01/21.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Igor\"}".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}
