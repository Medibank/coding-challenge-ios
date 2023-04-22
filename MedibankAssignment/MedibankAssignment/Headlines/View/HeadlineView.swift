//
//  HeadlineView.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation
import UIKit

enum HeadlineViewViewConstant {
    static let width: CGFloat = 87.0
    static let height: CGFloat = 71.0
    static let estimatedRowHeight: CGFloat = 156.0
}

class HeadlineView: UIView, HeadlineDisplayer
{
    
    let headlineTableView = UITableView(frame: .zero, style: .insetGrouped)
    let loadingView = CustomLoadingView(frame: .zero)
    let adapter = HeadlineAdapter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(headlineTableView)
        self.addSubview(loadingView)
        headlineTableView.delegate = adapter
        headlineTableView.dataSource = adapter
        headlineTableView.estimatedRowHeight = HeadlineViewViewConstant.estimatedRowHeight
        headlineTableView.rowHeight = UITableView.automaticDimension
        headlineTableView.showsVerticalScrollIndicator = false
        adapter.registerCells(with: headlineTableView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        headlineTableView.pinToSuperviewEdges()
        loadingView.pinCenterX(to: self)
        loadingView.pinCenterY(to: self)
        loadingView.addWidthConstraint(constant: HeadlineViewViewConstant.width)
        loadingView.addHeightConstraint(constant: HeadlineViewViewConstant.height)
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func update(with errorViewState: ErrorViewState) {
    }
    
    func update(with viewState: HeadlineViewState, fetchMethod: FetchMethod) {
        loadingView.isHidden = true
        adapter.update(with: viewState, tableView: headlineTableView, fetchMethod: fetchMethod)
    }
    
    func attachListener(listener: HeadlineActionListener) {
        adapter.attachListener(listener: listener)
    }
}
