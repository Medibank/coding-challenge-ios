//
//  ViewController.swift
//  MedibankAssignment
//
//  Created by Rohit  on 9/2/2023.
//

import UIKit
enum ViewControllerConstant {
    static let title = "Sources"
}

class ViewController: UIViewController {

    private let viewModel: SourceViewModeling
    private let sourceView = SourceView()
  
    init(coordinator: Coordinator) {
        let repository: SourceRepository = SourceViewRepository(manager: MedibankDownloadManager())
        let useCase: SourceUseCase = SourceViewUseCase(repository: repository)
        let viewModel = SourceViewModel(usecase: useCase, displayer: sourceView, coordinator: coordinator)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ViewControllerConstant.title
        view.addSubview(sourceView)
        sourceView.pinToSuperviewEdges()
        viewModel.startPresenting()
    }
}

