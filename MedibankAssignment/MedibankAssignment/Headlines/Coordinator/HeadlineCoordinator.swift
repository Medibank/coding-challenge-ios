//
//  HeadlineCoordinator.swift
//  MedibankAssignment
//
//  Created by Rohit  on 11/2/2023.
//

import Foundation
import UIKit

protocol ArticleCoordinator: Coordinator {
    func routeToWebView(article: Article)
}

class HeadlineCoordinator: ArticleCoordinator {
    var rootViewController = UINavigationController()
    
    lazy var viewController: HeadlineViewController = {
        let vc = HeadlineViewController(coordinator: self)
        vc.title = "Headline"
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
