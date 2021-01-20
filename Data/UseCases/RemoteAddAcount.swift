//
//  RemoteAddAcount.swift
//  Data
//
//  Created by Igor Custodio on 20/01/21.
//

import Foundation
import Domain

public final class RemoteAddAcount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAcountModel: AddAcountModel, completion: @escaping (DomainError) -> Void) {
        httpClient.post(to: self.url, with: addAcountModel.toData()) { error in
            completion(.unexpected)
        }
    }
}
