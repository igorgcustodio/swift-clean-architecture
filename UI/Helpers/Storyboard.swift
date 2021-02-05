//
//  Storyboard.swift
//  UI
//
//  Created by Igor Custodio on 04/02/21.
//

import UIKit

public protocol Storyboard {
    static func instantiate() -> Self
}

extension Storyboard where Self: UIViewController {
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        
        return sb.instantiateViewController(identifier: vcName) as Self
    }
}
