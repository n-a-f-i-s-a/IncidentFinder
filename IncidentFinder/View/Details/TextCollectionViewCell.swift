//
//  DetailCollectionViewCell.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

final class TextCollectionViewCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    static let reuseIdentifier = "textCell"
    
    func configure(textCellViewModel: TextCellViewModel) {
        self.titleLabel.text = textCellViewModel.title
        self.subtitleLabel.text = textCellViewModel.subtitle
    }
    
}

private extension TextCollectionViewCell {
    
    func configureStyle() {
        self.titleLabel.textColor = .secondaryFontColor
    }
    
}
