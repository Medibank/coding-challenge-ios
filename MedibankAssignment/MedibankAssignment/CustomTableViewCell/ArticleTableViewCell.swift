//
//  ArticleTableViewCell.swift
//  MedibankAssignment
//
//  Created by Rohit  on 13/2/2023.
//

import UIKit
import Kingfisher

extension String {
    func trim() -> String {
          return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    private var toSaveAction: (() -> Void)?
    
    func configureCell(article: Article, saveAction: (() -> Void)?) {
        toSaveAction = saveAction
        articleTitleLabel.text = article.title.trim()
        descriptionLabel.text = article.description.trim()
        autherLabel.text = article.author ?? ""
        articleImageView.layer.cornerRadius = 10.0
        bookmarkButton.isSelected = article.isSaved ?? false
        guard let url = URL(string: article.urlToImage ?? "") else {
            articleImageView.image = UIImage(systemName: "newspapers")
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: article.urlToImage)
        articleImageView.kf.setImage(with: resource)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        toSaveAction?()
    }
}
