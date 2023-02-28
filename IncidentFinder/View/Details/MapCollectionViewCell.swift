//
//  MapCollectionViewCell.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import MapKit
import UIKit

final class MapCollectionViewCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    static let reuseIdentifier = "mapCell"
    
    func configure(mapCellViewModel: MapCellViewModel) {
        let region = self.mapView.regionThatFits(
            MKCoordinateRegion(
                center: mapCellViewModel.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        )
        self.mapView.setRegion(region, animated: true)
    }
    
}
