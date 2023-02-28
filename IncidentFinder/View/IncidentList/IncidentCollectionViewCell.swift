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
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var lastUpdatedLabel: UILabel!
    @IBOutlet private weak var titlelabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
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
    
    func configureStyle(incidentCellViewModel: IncidentCellViewModel) {
        self.statusLabel.backgroundColor = UIColor.makeBadgeColor(status: incidentCellViewModel.status)
        self.statusLabel.layer.cornerRadius = 10.0
    }
    
    func showImage(incidentCellViewModel: IncidentCellViewModel) {
        Task { [weak self] in
            do {
               let imageData = try await incidentCellViewModel.getImageData()
                self?.imageView.image = UIImage(data: imageData)
            } catch {
            }
        }
    }
    
}
