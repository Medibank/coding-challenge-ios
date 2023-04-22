//
//  MainNavigator.swift
//  MedibankAssignment
//
//  Created by Rohit  on 9/2/2023.
//

import UIKit

enum MainNavigatorConstant {
    static let source = "Source"
    static let headlines = "Headlines"
    static let saved = "Saved"
    static let houseImage = UIImage(systemName: "house")!
    static let newspaperImage = UIImage(systemName: "newspaper")!
    static let savedImage = UIImage(systemName: "square.and.arrow.down")!
}

class MainNavigator: Coordinator {
    private var window: UIWindow
    var childCoordinators = [Coordinator]()
    var rootViewController: UITabBarController
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        rootViewController.view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        rootViewController.tabBar.tintColor = .label
    }

    func start() {
        let sourceCoordinator = SourceViewCoordinator()
        sourceCoordinator.start()
        setup(for: sourceCoordinator.rootViewController, title: MainNavigatorConstant.source, image: MainNavigatorConstant.houseImage)
        self.childCoordinators.append(sourceCoordinator)
        
        let headlineCoordinator = HeadlineCoordinator()
        headlineCoordinator.start()
        setup(for: headlineCoordinator.rootViewController, title: MainNavigatorConstant.headlines, image: MainNavigatorConstant.newspaperImage)
        self.childCoordinators.append(headlineCoordinator)

        let savedCoordinator = SavedCoordinator()
        savedCoordinator.start()
        setup(for: savedCoordinator.rootViewController, title: MainNavigatorConstant.saved, image: MainNavigatorConstant.savedImage)
        self.childCoordinators.append(savedCoordinator)
        
        rootViewController.viewControllers = [sourceCoordinator.rootViewController, headlineCoordinator.rootViewController, savedCoordinator.rootViewController]
        window.rootViewController = rootViewController
    }
    
    fileprivate func setup(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) {
        rootViewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        rootViewController.navigationItem.title = title
      }
}
