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
    static func makeRemoteAddAccount() -> AddAccount {
        let url = URL(string: "http://localhost:5050/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        return RemoteAddAcount(url: url, httpClient: alamofireAdapter)
    }
}
