//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Igor Custodio on 26/01/21.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    
    var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }
}
