//
//  HeadlineViewModel.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation
import RxSwift

protocol HeadlineViewModeling {
    func startPresenting()
}

struct HeadlineActionListener {
    let toSelectionAction: (Article) -> Void
    let toSaveAction: (Article) -> Void
    init(toSelectionAction: @escaping (Article) -> Void, toSaveAction: @escaping (Article) -> Void) {
        self.toSelectionAction = toSelectionAction
        self.toSaveAction = toSaveAction
    }
}

struct HeadlineViewState {
    let contents: [Article]
}

enum HeadlineDataState {
    case loading
    case idleState(HeadlineViewState)
    case errorState(ErrorViewState)
}

protocol HeadlineDisplayer {
    func update(with viewState: HeadlineViewState, fetchMethod: FetchMethod)
    func update(with errorViewState: ErrorViewState)
    func attachListener(listener: HeadlineActionListener)
    func showLoadingView()
}

struct HeadlineViewModelConstant {
    static let filename = "news.json"
}

enum FetchMethod {
    case web
    case local
}

class HeadlineViewModel: HeadlineViewModeling {
    private let usecase: HeadlineUseCase
    private let disposeBag = DisposeBag()
    private let coordinator: ArticleCoordinator
    private let displayer: HeadlineDisplayer
    private let localStorage: LocalStorage
    private let fetchMethod: FetchMethod
    
    init(usecase: HeadlineUseCase,
         displayer: HeadlineDisplayer,
         coordinator: ArticleCoordinator,
         fetchMethod: FetchMethod = .web,
         localStorage: LocalStorage = LocalDataStorage(fileName: HeadlineViewModelConstant.filename)) {
        self.usecase = usecase
        self.fetchMethod = fetchMethod
        self.coordinator = coordinator
        self.displayer = displayer
        self.localStorage = localStorage
    }
    
    func startPresenting() {
        let observable = (fetchMethod == .web) ? fetchArticles() : fetchArticlesFromLocal()
        fetchHeadlines(observable: observable)
        
        displayer.attachListener(listener: HeadlineActionListener(toSelectionAction: { [weak self] article in
            self?.coordinator.routeToWebView(article: article)
        }, toSaveAction: { [weak self] article in
            guard let self = self else { return }
            (article.isSaved ?? false) ? self.localStorage.addArticleToLocal(item: article) : self.localStorage.deleteArticleFromLocal(item: article)
        }))
    }
    
    private func fetchArticles() -> Observable<HeadlineDataState> {
        usecase.fetchHeadlines()
    }

    private func fetchArticlesFromLocal() -> Observable<HeadlineDataState> {
        usecase.fetchSavedArticles()
    }
    
    private func fetchHeadlines(observable: Observable<HeadlineDataState>) {
        observable.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] dataState in
            guard let self = self else { return }
            switch dataState {
            case .loading:
                self.displayer.showLoadingView()
            case .errorState(let viewState):
                self.displayer.update(with: viewState)
            case .idleState(let viewState):
                self.displayer.update(with: viewState, fetchMethod: self.fetchMethod)
            }
        }).disposed(by: disposeBag)
    }
}

