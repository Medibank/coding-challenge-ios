//
//  SourceUseCaseSpy.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 14/2/2023.
//

import Foundation
import RxSwift
@testable import MedibankAssignment


enum StateType {
    case loading
    case idle
    case error
}

class SourceUseCaseSpy: SourceUseCase {
    var hasFetchSourcesCalled = false
    let stateType: StateType
    
    init(stateType: StateType) {
        self.stateType = stateType
    }
    
    func fetchSources() -> RxSwift.Observable<MedibankAssignment.DataState> {
        hasFetchSourcesCalled = true
        switch stateType {
        case .loading:
            return RxSwift.Observable.just(DataState.loading)
        case .error:
            return RxSwift.Observable.just(DataState.errorState(ErrorViewState(error: MedibankNetworkError.badMapping)))
        case .idle:
            return RxSwift.Observable.just(DataState.idleState(ContentViewState(contents: [])))
        }
    }
}
