//
//  DetailViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation
import CoreLocation

final public class DetailViewModel {
    
    // MARK: - Type
    
    /// Section Type.

    enum Section: CaseIterable {
        case info
    }
    
    /// Item Type.

    enum Item: Hashable {
        case map(Incident)
        case location(String)
        case status(String)
        case type(String)
        case callTime(String)
        case description(String)
        
        var title: String {
            switch self {
            case .map:
                return "Map"
            case .status:
                return "Status"
            case .type:
                return "Type"
            case .callTime:
                return "Call Time"
            case .description:
                return "Description"
            case .location:
                return "Location"
            }
        }
        
        var subtitle: String {
            switch self {
            case .location(let location):
                return location
            case .map(_):
                return ""
            case .status(let status):
                return status
            case .type(let type):
                return type
            case .callTime(let callTime):
                return callTime
            case .description(let description):
                return description
            }
        }
    }
    
    var incident: Incident
    var imageCache: ImageCacheProtocol
    
    init(
        incident: Incident,
        imageCache: ImageCacheProtocol
    ) {
        self.incident = incident
        self.imageCache = imageCache
    }
    
}

public extension DetailViewModel {
    
    var title: String {
        incident.title
    }
    
    var imageName: String {
        "arrow.triangle.turn.up.right.diamond.fill"
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: incident.latitude,
            longitude: incident.longitude
        )
    }
    
}
