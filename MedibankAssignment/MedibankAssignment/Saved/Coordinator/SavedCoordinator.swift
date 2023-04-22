//
//  SavedCoordinator.swift
//  MedibankAssignment
//
//  Created by Rohit  on 11/2/2023.
//

import Foundation
import UIKit

class SavedCoordinator: ArticleCoordinator {
    var rootViewController = UINavigationController()
    
    lazy var viewController: SavedViewController = {
        let vc = SavedViewController(coordinator: self)
        vc.title = "Saved"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func routeToWebView(article: Article) {
        guard let url = URL(string: article.url) else { return }
        let vc = ArticleWebViewController(urlRequest: URLRequest(url: url))
        rootViewController.present(vc, animated: true)
    }
}
