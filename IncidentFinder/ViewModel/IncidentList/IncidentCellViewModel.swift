//
//  IncidentCellViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

final class IncidentCellViewModel {
    
    // MARK: - properties
    
    var incidentService: IncidentServiceProtocol
    var lastUpdated: Date
    var title: String
    var status: Incident.StatusType
    var imageURL: URL
    var imageCache: ImageCacheProtocol
    
    init(
        incidentService: IncidentService,
        lastUpdated: Date,
        title: String,
        status: Incident.StatusType,
        imageURL: URL,
        imageCache: ImageCacheProtocol
    ) {
        self.incidentService = incidentService
        self.lastUpdated = lastUpdated
        self.title = title
        self.status = status
        self.imageURL = imageURL
        self.imageCache = imageCache
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

    func getImageData() async throws -> UIImage? {
        do {
            if let cachedImage = imageCache.getCachedImage(urlString: imageURL.absoluteString as NSString) {
                return cachedImage
            }
            let imageData = try await incidentService.getImageData(url: imageURL)
            
            if let image = UIImage(data: imageData) {
                imageCache.cacheImage(image: image, urlString: imageURL.absoluteString as NSString)
                return image
            }
            return nil
        } catch {
            throw error
        }
    }

}
