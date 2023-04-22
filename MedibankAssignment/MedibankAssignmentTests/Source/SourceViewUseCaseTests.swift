//
//  SourceViewUseCaseTests.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 15/2/2023.
//

import XCTest
import RxSwift
@testable import MedibankAssignment

final class SourceViewUseCaseTests: XCTestCase {

    let sourceRepositorySpy = SourceRepositorySpy(responseState: .error)
    var sut: SourceViewUseCase!
    
    override func setUpWithError() throws {
        sut = SourceViewUseCase(repository: sourceRepositorySpy)
    }

    func testFetchSourcesShouldCallFetchSourcesInRepository() throws {
        _ = sut.fetchSources()
        XCTAssertTrue(sourceRepositorySpy.hasFetchSourcesCalled)
    }
}
