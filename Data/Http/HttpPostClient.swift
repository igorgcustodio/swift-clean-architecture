//
//  HttpPostClient.swift
//  Data
//
//  Created by Igor Custodio on 20/01/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
