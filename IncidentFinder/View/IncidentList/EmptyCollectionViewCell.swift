//
//  EmptyCollectionViewCell.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    static var reuseIdentifier = "emptyCell"
    
    @IBOutlet private weak var emptyMessageLabelView: UILabel!
    
    func configure(emptyCellViewModel: EmptytCellViewModel) {
        self.emptyMessageLabelView.text = emptyCellViewModel.title
    }

}
