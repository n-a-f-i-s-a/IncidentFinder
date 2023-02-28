//
//  Incident.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation

struct Incident: Codable, Hashable {
    let title: String
    let callTime: Date
    let lastUpdated: Date
    let id: String
    let latitude: Double
    let longitude: Double
    let description: String?
    let location: String
    let status: StatusType
    let type: String
    let typeIcon: URL
    
    enum StatusType: String, Codable {
        case onScene = "On Scene"
        case underControl = "Under control"
        case outOfControl = "Out of control"
        case pending = "Pending"
    }
}
