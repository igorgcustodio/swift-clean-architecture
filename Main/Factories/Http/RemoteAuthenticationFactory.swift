//
//  UseCaseFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation
import Data
import Domain

func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
