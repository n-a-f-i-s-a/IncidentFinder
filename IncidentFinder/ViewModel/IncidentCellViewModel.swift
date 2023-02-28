//
//  IncidentCellViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation


final class IncidentCellViewModel {
    
    // MARK: - properties
    
    var incidentService: IncidentServiceProtocol
    var lastUpdated: Date
    var title: String
    var status: Incident.StatusType
    var imageURL: URL
    
    init(
        incidentService: IncidentService,
        lastUpdated: Date,
        title: String,
        status: Incident.StatusType,
        imageURL: URL
    ) {
        self.incidentService = incidentService
        self.lastUpdated = lastUpdated
        self.title = title
        self.status = status
        self.imageURL = imageURL
    }
    
}

extension IncidentCellViewModel {
    
    var statusString: String {
        status.rawValue
    }
    
    var formattedlastUpdated: String {
        Formatter.formattedDateString(date: lastUpdated)
    }
    
    /// Returns the image data of a selected incident icon type from the API.
    ///
    /// - Parameters:
    ///    - url: The image url of an incident icon.

    func getImageData() async throws -> Data {
        do {
            return try await incidentService.getImageData(url: imageURL)
        } catch {
            throw error
        }
    }

}
