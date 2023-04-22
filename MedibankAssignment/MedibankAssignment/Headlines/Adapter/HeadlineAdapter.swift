//
//  HeadlineAdapter.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import UIKit

enum HeadlineAdapterConstant {
    static let identifire = "ArticleTableViewCell"
    static let nibName = "ArticleTableViewCell"
}

class HeadlineAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var contents = [Article]()
    private var toSelectionAction: ((Article) -> Void)?
    private var toSaveAction: ((Article) -> Void)?
    private var fetchMethod: FetchMethod = .web

    func registerCells(with tableView: UITableView) {
        tableView.register(UINib(nibName: HeadlineAdapterConstant.nibName, bundle: nil), forCellReuseIdentifier: HeadlineAdapterConstant.identifire)
    }
    
    func attachListener(listener: HeadlineActionListener) {
        toSelectionAction = listener.toSelectionAction
        toSaveAction = listener.toSaveAction
    }

    private func procssArticle(indexPath: IndexPath, tableView: UITableView, article: Article) {
        if fetchMethod == .local {
            guard let index = contents.firstIndex(where: {$0.title == article.title}) else { return }
            contents.remove(at: index)
            deleteSection(indexPath: index, tableView: tableView)
        }
    }
    
    private func deleteSection(indexPath: Int, tableView: UITableView) {
        let indexset = IndexSet(integer: indexPath)
        tableView.beginUpdates()
        tableView.deleteSections(indexset, with: .automatic)
        tableView.endUpdates()
    }
    
    func update(with contentViewState: HeadlineViewState, tableView: UITableView, fetchMethod: FetchMethod) {
        self.fetchMethod = fetchMethod
        contents = contentViewState.contents
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 0.0 : 16.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineAdapterConstant.identifire) as! ArticleTableViewCell
        let article = contents[indexPath.section]
        cell.configureCell(article: article) { [weak self] in
            article.isSaved = !(article.isSaved ?? false)
            self?.toSaveAction?(article)
            self?.procssArticle(indexPath: indexPath, tableView: tableView, article: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toSelectionAction?(contents[indexPath.section])
    }
}
