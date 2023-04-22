//
//  DownloadManagerSpy.swift
//  MedibankAssignmentTests
//
//  Created by Rohit  on 15/2/2023.
//

import Foundation
import RxSwift
@testable import MedibankAssignment

class DownloadManagerSpy: DownloadManager {
    var hasMakeGetApiCalled = false
    
    func makeGetApiCall<T>(url: URL, type: T.Type) -> RxSwift.Observable<Result<T, Error>> where T : Decodable, T : Encodable {
        hasMakeGetApiCalled = true
        return Observable.empty()
    }
    
    
}
