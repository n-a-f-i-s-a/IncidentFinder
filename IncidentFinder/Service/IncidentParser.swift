//
//  IncidentParser.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation

final class IncidentParser {
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = .withInternetDateTime
            
            if let date = formatter.date(from: dateString) {
                return date
            }
           
            throw DecodingError.dataCorruptedError(in: container,
                debugDescription: "Cannot decode date string \(dateString)")
        }
        return decoder
    }
    
}

extension IncidentParser: IncidentParserProtocol {
    
    func parseResult(data: Data) async throws -> [Incident] {
        do {
            return try self.decoder.decode([Incident].self, from: data)
        } catch {
            throw error
        }
    }
    
}
