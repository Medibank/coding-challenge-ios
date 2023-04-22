//
//  CustomLoadingView.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import UIKit

class CustomLoadingView: UIView {
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        containerView.addSubview(activityIndicator)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        addConstraints()
    }
    
    private func addConstraints() {
        containerView.pinToSuperviewEdges()
        activityIndicator.pinCenterX(to: containerView)
        activityIndicator.pinCenterY(to: containerView)
        activityIndicator.addWidthConstraint(constant: 20.0)
        activityIndicator.addHeightConstraint(constant: 20.0)
    }
}
