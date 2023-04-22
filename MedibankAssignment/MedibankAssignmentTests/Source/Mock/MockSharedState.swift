//
//  MockSharedState.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 14/2/2023.
//

import Foundation
@testable import MedibankAssignment

class MockSharedState: SharedState {
    var sources: [MedibankAssignment.Source] = []
    var hasAddSourceCalled = false
    var hasRemoveSourceCalled = false
    var hasGetCommaSeparatedSourcesCalled = false
    
    func addSource(source: MedibankAssignment.Source) {
        hasAddSourceCalled = true
    }
    
    func removeSource(source: MedibankAssignment.Source) {
        hasRemoveSourceCalled = true
    }
    
    func getCommaSeparatedSources() -> String {
        hasGetCommaSeparatedSourcesCalled = true
        return ""
    }
}
