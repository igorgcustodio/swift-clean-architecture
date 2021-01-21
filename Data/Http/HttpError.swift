//
//  HttpError.swift
//  Data
//
//  Created by Igor Custodio on 20/01/21.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
