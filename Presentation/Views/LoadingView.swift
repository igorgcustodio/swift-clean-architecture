//
//  LoadingView.swift
//  Presentation
//
//  Created by Igor Custodio on 26/01/21.
//

import Foundation

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init (isLoading: Bool) {
        self.isLoading = isLoading
    }
}
