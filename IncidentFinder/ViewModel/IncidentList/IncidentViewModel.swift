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

    enum PushedViewModel {
        case detail(DetailViewModel)
    }
    
    // MARK: - properties

    private let incidentService: IncidentServiceProtocol
    public var state: State
    var incidents: [Incident]
    let imageCache: ImageCacheProtocol
    
    /// Initializes a view model.
    ///
    /// - Parameters:
    ///    - incidentService: The service to be used to fetch data from API.

    init(incidentService: IncidentServiceProtocol) {
        self.incidentService = incidentService
        self.incidents = []
        self.state = .idle
        imageCache = ImageCache()
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
    
    /// Sorts the incidents in ascending or decsending order.
    ///
    /// - Parameters:
    ///     - isDescending: Indicates the sort order
    
    func sortIncidents(isDescending: Bool ) {
        isDescending
            ? incidents.sort { $0.lastUpdated > $1.lastUpdated }
            : incidents.sort { $0.lastUpdated < $1.lastUpdated }
    }
    
    /// Returns the pushedViewModel for the next screen.
    ///
    /// - Parameters:
    ///     - row: The row index to obtain the corresponding object ID.
    ///  - Returns: A view model to be pushed.

    func selectItem(row: Int) -> PushedViewModel? {
        if incidents.indices.contains(row) {
            return
                .detail(
                    DetailViewModel(
                        incident: incidents[row],
                        imageCache: imageCache
                    )
                )
        }
        
        return nil
    }
    
}

public extension IncidentViewModel {
    
    var title: String {
        "Incidents"
    }
    
    var imageName: String {
        "arrow.up.arrow.down"
    }

}

extension IncidentViewModel.State: Equatable {
    public static func == (lhs: IncidentViewModel.State, rhs: IncidentViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.empty, .empty):
            return true
        case (.loading,.loaded):
            return false
        default:
            return false
        }
    }
    
}
