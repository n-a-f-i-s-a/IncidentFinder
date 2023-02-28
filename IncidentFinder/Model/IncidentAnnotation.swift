//
//  IncidentAnnotation.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import MapKit

final class IncidentAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let image: UIImage?
    
    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D,
        image: UIImage?
    ){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.image = image
        
        super.init()
    }
}
