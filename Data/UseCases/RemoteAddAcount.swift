//
//  RemoteAddAcount.swift
//  Data
//
//  Created by Igor Custodio on 20/01/21.
//

import Foundation
import Domain

public final class RemoteAddAcount: AddAcount {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAcountModel: AddAcountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: self.url, with: addAcountModel.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: AccountModel = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}