//
//  UseCaseFactory.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation

func makeApiUrl(path: String) -> URL {
    return URL(string: "\(Environment.variable(.apiBaseUrl))/\(path)")!
}
