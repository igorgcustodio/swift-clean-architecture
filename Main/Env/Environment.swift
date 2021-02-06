//
//  Environment.swift
//  Main
//
//  Created by Igor Custodio on 06/02/21.
//

import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
