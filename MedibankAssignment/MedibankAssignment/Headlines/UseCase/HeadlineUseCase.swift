//
//  HeadlineUseCase.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation
import RxSwift

protocol HeadlineUseCase {
    func fetchHeadlines() -> Observable<HeadlineDataState>
    func fetchSavedArticles() -> Observable<HeadlineDataState>
}

struct HeadlineViewUseCase: HeadlineUseCase {
    private let repository: HeadlineRepository
    private var dataState = BehaviorSubject(value: HeadlineDataState.loading)
    private let localDataStorage: LocalStorage
    
    init(repository: HeadlineRepository, localDataStorage: LocalStorage = LocalDataStorage(fileName: HeadlineViewModelConstant.filename)) {
        self.repository = repository
        self.localDataStorage = localDataStorage
    }
    
    func fetchSavedArticles() -> Observable<HeadlineDataState> {
        callLocalRepoForSavedArticle()
        return dataState.asObservable()
    }
    
    private func callLocalRepoForSavedArticle() {
        let articles = localDataStorage.getArticles()
        dataState.onNext(HeadlineDataState.idleState(HeadlineViewState(contents: articles)))
    }
    
    private func callRepoForHeadline() {
        _ = repository.fetchHeadlines(type: HeadlineResponse.self).subscribe(onNext: { result in
            switch result {
            case .success(let response):
                dataState.onNext(HeadlineDataState.idleState(HeadlineViewState(contents: response.articles)))
            case .failure(let error):
                dataState.onNext(HeadlineDataState.errorState(ErrorViewState(error: error)))
            }
        }, onError: { error in
            dataState.onNext(HeadlineDataState.errorState(ErrorViewState(error: error)))
        })
    }
    
    func fetchHeadlines() -> Observable<HeadlineDataState> {
        callRepoForHeadline()
        return dataState.asObservable()
    }
}
