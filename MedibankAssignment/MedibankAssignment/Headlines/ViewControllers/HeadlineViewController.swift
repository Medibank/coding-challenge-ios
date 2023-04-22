//
//  HeadlineViewController.swift
//  MedibankAssignment
//
//  Created by Rohit  on 9/2/2023.
//

import UIKit
enum HeadlineViewControllerConstant {
    static let title = "Headlines"
}

class HeadlineViewController: UIViewController {
    private let viewModel: HeadlineViewModeling
    private let headlineView = HeadlineView()
  

    init(coordinator: ArticleCoordinator) {
        let repository: HeadlineRepository = HeadlineViewRepository(manager: MedibankDownloadManager())
        let useCase: HeadlineViewUseCase = HeadlineViewUseCase(repository: repository)
        let viewModel = HeadlineViewModel(usecase: useCase, displayer: headlineView, coordinator: coordinator)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HeadlineViewControllerConstant.title
        view.addSubview(headlineView)
        headlineView.pinToSuperviewEdges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startPresenting()
    }
}