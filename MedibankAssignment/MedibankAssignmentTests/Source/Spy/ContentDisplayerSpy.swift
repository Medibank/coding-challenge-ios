//
//  ContentDisplayerSpy.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 14/2/2023.
//

import Foundation
@testable import MedibankAssignment

class ContentDisplayerSpy: ContentDisplayer {
    var updateWithViewStateCalled = false
    var updateWithErrorViewStateCalled = false
    var attachListenerCalled = false
    var showLoadingViewCalled = false

    func update(with viewState: MedibankAssignment.ContentViewState) {
        updateWithViewStateCalled = true
    }
    
    func update(with errorViewState: MedibankAssignment.ErrorViewState) {
        updateWithErrorViewStateCalled = true
    }
    
    func attachListener(listener: MedibankAssignment.ContentActionListener) {
        attachListenerCalled = true
    }
    
    func showLoadingView() {
        showLoadingViewCalled = true
    }
}
