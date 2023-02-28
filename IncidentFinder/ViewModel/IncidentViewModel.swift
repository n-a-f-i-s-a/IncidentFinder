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
    
    // MARK: - properties

    private let incidentService: IncidentServiceProtocol
    var incidents: [Incident]
    
    /// Initializes a view model.
    ///
    /// - Parameters:
    ///    - incidentService: The service to be used to fetch data from API.

    init(incidentService: IncidentServiceProtocol) {
        self.incidentService = incidentService
        self.incidents = []
    }
}

extension IncidentViewModel {
    
    func getIncidents() {
        Task { [weak self] in
            do {
                self?.incidents = []
                try await self?.fetchIncidents()
            } catch {
                throw error
            }
        }
    }
    
    /// Fetches the incidents from the API.
    
    func fetchIncidents() async throws {
        do {
            let result = try await incidentService.getData()
            print(result)
        } catch {
            throw error
        }
    }
    
}
