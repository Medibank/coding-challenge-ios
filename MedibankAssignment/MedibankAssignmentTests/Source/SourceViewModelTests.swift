//
//  SourceViewModelTests.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 14/2/2023.
//

import XCTest
@testable import MedibankAssignment

final class SourceViewModelTests: XCTestCase {

    let usecase = SourceUseCaseSpy(stateType: .loading)
    let contentDisplayer = ContentDisplayerSpy()
    let coordinator = MockCoordinator()
    var sut: SourceViewModel!

    override func setUpWithError() throws {
        sut = SourceViewModel(usecase: usecase, displayer: contentDisplayer, coordinator: coordinator)
    }

    func testStartPresentingShouldCalledAttachListenerCorrectly() throws {
        sut.startPresenting()
        
        XCTAssertTrue(contentDisplayer.attachListenerCalled)
    }
    
    func testStartPresentingShouldCalledFetchSourcesinUsecase() throws {
        sut.startPresenting()
        
        XCTAssertTrue(usecase.hasFetchSourcesCalled)
    }
    
    func testStartPresentingShouldCalledShowLoadingViewWhenDataStateIsLoading() throws {
        let usecase = SourceUseCaseSpy(stateType: .loading)
        let contentDisplayer = ContentDisplayerSpy()
        sut = SourceViewModel(usecase: usecase, displayer: contentDisplayer, coordinator: coordinator)
        
        sut.startPresenting()
        
        XCTAssertTrue(contentDisplayer.showLoadingViewCalled)
    }
    
    func testStartPresentingShouldCalledUpdateWithErrorViewStateWhenDataStateIsError() throws {
        let usecase = SourceUseCaseSpy(stateType: .error)
        let contentDisplayer = ContentDisplayerSpy()
        let sut = SourceViewModel(usecase: usecase, displayer: contentDisplayer, coordinator: coordinator)

        sut.startPresenting()
        
        XCTAssertTrue(contentDisplayer.updateWithErrorViewStateCalled)
    }

    func testStartPresentingShouldCalledUpdateWithIdleViewStateWhenDataStateIsIdle() throws {
        let usecase = SourceUseCaseSpy(stateType: .idle)
        let contentDisplayer = ContentDisplayerSpy()
        let sut = SourceViewModel(usecase: usecase, displayer: contentDisplayer, coordinator: coordinator)

        sut.startPresenting()
        
        XCTAssertTrue(contentDisplayer.updateWithViewStateCalled)
    }

}
