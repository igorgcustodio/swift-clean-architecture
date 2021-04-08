//
//  UseCaseFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Data
import Domain

func makeRemoteAddAccount() -> AddAccount {
    return makeRemoteAddAccountWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddAccountWith(httpClient: HttpPostClient) -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "signup"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddAccount)
}
