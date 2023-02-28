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
    
    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
}
