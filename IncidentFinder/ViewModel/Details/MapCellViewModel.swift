//
//  MapCellViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation
import CoreLocation

final class MapCellViewModel {
    
    // MARK: - properties
    
    var incidentAnnotation: IncidentAnnotation
    
    init(incidentAnnotation: IncidentAnnotation) {
        self.incidentAnnotation = incidentAnnotation
    }

}
