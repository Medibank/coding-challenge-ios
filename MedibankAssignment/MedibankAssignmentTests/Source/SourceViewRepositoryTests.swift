//
//  SourceViewRepositoryTests.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 15/2/2023.
//

import XCTest
@testable import MedibankAssignment

final class SourceViewRepositoryTests: XCTestCase {

    var Sut: SourceViewRepository!
    let downloadManagerSpy = DownloadManagerSpy()
    
    func testShouldCallMakeGetApiCallInDownloadManager() {
        Sut = SourceViewRepository(manager: downloadManagerSpy)
        
        _ = Sut.fetchSources(type: SourceResponse.self)
        
        XCTAssertTrue(downloadManagerSpy.hasMakeGetApiCalled)
    }
}
