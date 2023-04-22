//
//  SourceTableViewCell.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    func configureCell(source: Source) {
        sourceTitleLabel.text = source.name
        selectionImageView.isHidden = !(source.isSelected ?? false)
    }
}
