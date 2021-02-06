//
//  UseCaseFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Data
import Infra
import Domain

class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseUrl)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        return RemoteAddAcount(url: makeUrl(path: "signup"), httpClient: httpClient)
    }
}