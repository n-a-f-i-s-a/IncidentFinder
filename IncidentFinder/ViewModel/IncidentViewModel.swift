//
//  IncidentViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation


final public class IncidentViewModel {
    
    // MARK: - Type

    /// Section Type.

    enum Section: CaseIterable {
        case basicInfo
        case empty
    }
    
    /// Item Type.

    enum Item: Hashable {
        case incident(Incident)
        case empty(Int)
    }
    
    /// Different states.
    public enum State {
        /// User hasn't searched.
        case idle

        /// Data is being fetched.
        case loading

        /// Data has been loaded.
        case loaded

        /// API has not returned any data.
        case empty
        
        /// Encountered an error
        case error(Error)
    }

    
    // MARK: - properties

    private let incidentService: IncidentServiceProtocol
    public var state: State
    var incidents: [Incident]
    
    /// Initializes a view model.
    ///
    /// - Parameters:
    ///    - incidentService: The service to be used to fetch data from API.

    init(incidentService: IncidentServiceProtocol) {
        self.incidentService = incidentService
        self.incidents = []
        self.state = .idle
    }
}

extension IncidentViewModel {
    
    /// Fetches the incidents from the API.
    
    func fetchIncidents() async throws {
        do {
            incidents = try await incidentService.getData()
            sortIncidents(isDescending: true)
            state = .loaded
        } catch {
            state = .error(error)
            throw error
        }
    }
    
    func sortIncidents(isDescending: Bool ) {
        isDescending
            ? incidents.sort { $0.lastUpdated > $1.lastUpdated }
            : incidents.sort { $0.lastUpdated < $1.lastUpdated }
    }
    
}
