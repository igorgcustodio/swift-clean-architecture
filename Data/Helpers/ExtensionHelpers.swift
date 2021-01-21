//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Igor Custodio on 21/01/21.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
