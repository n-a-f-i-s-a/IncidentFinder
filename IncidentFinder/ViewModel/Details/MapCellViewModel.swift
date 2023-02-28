//
//  MapCellViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation
import CoreLocation

final class MapCellViewModel {
    
    var coordinates: CLLocationCoordinate2D
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
}
