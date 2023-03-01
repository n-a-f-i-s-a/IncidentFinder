//
//  CollectionViewCell.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

final class IncidentCollectionViewCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "IncidentCell"
    
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var badgeView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var lastUpdatedLabel: UILabel!
    @IBOutlet private weak var titlelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessories = [.disclosureIndicator()]
    }
    
    func configure(incidentCellViewModel: IncidentCellViewModel) {
        self.titlelabel.text = incidentCellViewModel.title
        self.statusLabel.text = incidentCellViewModel.statusString
        self.lastUpdatedLabel.text = incidentCellViewModel.formattedlastUpdated
        
        configureStyle(incidentCellViewModel: incidentCellViewModel)
        showImage(incidentCellViewModel: incidentCellViewModel)
    }
    
}

private extension IncidentCollectionViewCell {
    
    func configureStyle(incidentCellViewModel: IncidentCellViewModel) {
        badgeView.backgroundColor = UIColor.makeBadgeColor(status: incidentCellViewModel.status)
        self.statusLabel.backgroundColor = UIColor.makeBadgeColor(status: incidentCellViewModel.status)
        self.badgeView.layer.cornerRadius = 5.0
    }
    
    func showImage(incidentCellViewModel: IncidentCellViewModel) {
        Task { [weak self] in
            do {
                if let image = try await incidentCellViewModel.getImageData() {
                    self?.imageView.image = image.resizeImage(targetSize: CGSize(width: 40, height: 40))
                }
            } catch {
                // don't throw any error and show placeholder
            }
        }
    }
    
}
