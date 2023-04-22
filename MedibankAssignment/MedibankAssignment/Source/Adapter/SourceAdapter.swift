//
//  SourceAdapter.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import UIKit
enum SourceAdapterConstant {
    static let identifire = "SourceTableViewCell"
    static let nibName = "SourceTableViewCell"
}

class SourceAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var contents = [Source]()
    private var toSelectionAction: ((Source) -> Void)?
    
    func registerCells(with tableView: UITableView) {
        tableView.register(UINib(nibName: SourceAdapterConstant.nibName, bundle: nil), forCellReuseIdentifier: SourceAdapterConstant.identifire)
    }
    
    func attachListener(listener: ContentActionListener) {
        toSelectionAction = listener.toSelectionAction
    }

    func update(with contentViewState: ContentViewState, tableView: UITableView) {
        contents = contentViewState.contents
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SourceAdapterConstant.identifire) as! SourceTableViewCell
        let source = contents[indexPath.row]
        cell.configureCell(source: source)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = contents[indexPath.row]
        source.isSelected = !(source.isSelected ?? false)
        tableView.reloadRows(at: [indexPath], with: .none)
        toSelectionAction?(source)
    }
}
