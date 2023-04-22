//
//  SourceViewModel.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation
import RxSwift

struct ErrorViewState {
    let error: Error
}

struct ContentViewState {
    let contents: [Source]
}

enum DataState {
    case loading
    case idleState(ContentViewState)
    case errorState(ErrorViewState)
}

protocol SourceViewModeling {
    func startPresenting()
}

protocol ContentDisplayer {
    func update(with viewState: ContentViewState)
    func update(with errorViewState: ErrorViewState)
    func attachListener(listener: ContentActionListener)
    func showLoadingView()
}

struct ContentActionListener {
    let toSelectionAction: (Source) -> Void
    init(toSelectionAction: @escaping (Source) -> Void) {
        self.toSelectionAction = toSelectionAction
    }
}

class SourceViewModel: SourceViewModeling {
    private let usecase: SourceUseCase
    private let disposeBag = DisposeBag()
    private let coordinator: Coordinator
    private let displayer: ContentDisplayer
    private let sharedState: SharedState
    
    init(usecase: SourceUseCase, displayer: ContentDisplayer, coordinator: Coordinator, sharedState: SharedState = Singleton.shared) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.displayer = displayer
        self.sharedState = sharedState
    }
    
    func startPresenting() {
        fetchSources()
        displayer.attachListener(listener: ContentActionListener(toSelectionAction: { [weak self] source in
            guard let self = self, let isSelected = source.isSelected else { return }
            isSelected ? self.sharedState.addSource(source: source) : self.sharedState.removeSource(source: source)
        }))
    }
    
    private func fetchSources() {
        usecase.fetchSources().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] dataState in
            guard let self = self else { return }
            switch dataState {
            case .loading:
                self.displayer.showLoadingView()
            case .errorState(let viewState):
                self.displayer.update(with: viewState)
            case .idleState(let viewState):
                self.displayer.update(with: viewState)
            }
        }).disposed(by: disposeBag)
    }
    
}
