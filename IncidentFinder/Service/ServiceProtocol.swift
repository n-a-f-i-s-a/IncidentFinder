//
//  ServiceProtocol.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation

protocol IncidentServiceProtocol {
    func getData() async throws -> [Incident]
    func getImageData(url: URL) async throws -> Data
}

protocol IncidentParserProtocol {
    func parseResult(data: Data) async throws -> [Incident]
}
