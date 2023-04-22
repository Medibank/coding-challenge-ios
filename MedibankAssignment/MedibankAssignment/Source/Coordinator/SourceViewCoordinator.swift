//
//  SourceViewCoordinator.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation
import UIKit

class SourceViewCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    
    lazy var viewController: ViewController = {
        let vc = ViewController(coordinator: self)
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
