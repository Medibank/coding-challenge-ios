//
//  SourceView.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import UIKit

enum SourceViewConstant {
    static let width: CGFloat = 87.0
    static let height: CGFloat = 71.0
    static let estimatedRowHeight: CGFloat = 156.0
}

class SourceView: UIView, ContentDisplayer
{
    let sourceTableView = UITableView(frame: .zero, style: .insetGrouped)
    let loadingView = CustomLoadingView(frame: .zero)
    let adapter = SourceAdapter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(sourceTableView)
        self.addSubview(loadingView)
        sourceTableView.delegate = adapter
        sourceTableView.dataSource = adapter
        sourceTableView.estimatedRowHeight = SourceViewConstant.estimatedRowHeight
        sourceTableView.rowHeight = UITableView.automaticDimension
        adapter.registerCells(with: sourceTableView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        sourceTableView.pinToSuperviewEdges()
        loadingView.pinCenterX(to: self)
        loadingView.pinCenterY(to: self)
        loadingView.addWidthConstraint(constant: SourceViewConstant.width)
        loadingView.addHeightConstraint(constant: SourceViewConstant.height)
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func update(with viewState: ContentViewState) {
        loadingView.isHidden = true
        adapter.update(with: viewState, tableView: sourceTableView)
    }
    
    func update(with errorViewState: ErrorViewState) {
    }
    
    func attachListener(listener: ContentActionListener) {
        adapter.attachListener(listener: listener)
    }
}
