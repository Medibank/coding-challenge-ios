//
//  SourceRepositorySpy.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 15/2/2023.
//

import Foundation
import RxSwift
@testable import MedibankAssignment

enum ResponseState {
    case error
    case success
}
class SourceRepositorySpy: SourceRepository {
    let responseState: ResponseState
    var hasFetchSourcesCalled = false
    
    init(responseState: ResponseState) {
        self.responseState = responseState
    }
    
    func fetchSources<T>(type: T.Type) -> RxSwift.Observable<Result<T, Error>> where T : Decodable, T : Encodable {
        hasFetchSourcesCalled = true 
        switch responseState {
        case .error:
            return Observable.just(Result.failure(MedibankNetworkError.invalidResponse))
        case .success:
            return Observable.empty()
        }
    }
    
    
}
