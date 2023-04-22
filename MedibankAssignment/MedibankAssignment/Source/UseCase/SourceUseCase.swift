//
//  SourceUseCase.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation
import RxSwift

protocol SourceUseCase {
    func fetchSources() -> Observable<DataState>
}

struct SourceViewUseCase: SourceUseCase {
    private let repository: SourceRepository
    private var dataState = BehaviorSubject(value: DataState.loading)
    
    init(repository: SourceRepository) {
        self.repository = repository
    }
    
    private func callRepoForSources() {
        _ = repository.fetchSources(type: SourceResponse.self).subscribe(onNext: { result in
            switch result {
            case .success(let response):
                dataState.onNext(DataState.idleState(ContentViewState(contents: response.sources)))
            case .failure(let error):
                dataState.onNext(DataState.errorState(ErrorViewState(error: error)))
            }
        }, onError: { error in
            dataState.onNext(DataState.errorState(ErrorViewState(error: error)))
        })
    }
    
    func fetchSources() -> Observable<DataState> {
        callRepoForSources()
        return dataState.asObservable()
    }
}
