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
    
    @IBOutlet private weak var mapView: MKMapView!
    
    static let reuseIdentifier = "mapCell"
    let identifier = "incident"
    let placeholderImageName = "map.circle.fill"
    
    func configure(mapCellViewModel: MapCellViewModel) {
        let region = self.mapView.regionThatFits(
            MKCoordinateRegion(
                center: mapCellViewModel.incidentAnnotation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        )
        self.mapView.setRegion(region, animated: true)
        self.mapView.delegate = self
        addAnnotation(mapCellViewModel: mapCellViewModel)
    }
    
    func addAnnotation(mapCellViewModel: MapCellViewModel) {
        mapView.addAnnotation(mapCellViewModel.incidentAnnotation)
    }
    
}

extension MapCollectionViewCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? IncidentAnnotation else {
            return nil
        }

        var view: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            view.image = UIImage(systemName: placeholderImageName)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }

}
