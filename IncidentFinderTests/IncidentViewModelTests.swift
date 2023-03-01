//
//  IncidentFinderTests.swift
//  IncidentFinderTests
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import XCTest
@testable import IncidentFinder

final class IncidentViewModelTests: XCTestCase {
    
    private var testSubject: IncidentViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        testSubject = IncidentViewModel(incidentService: MockIncidentService())
    }

    override func tearDownWithError() throws {
        testSubject = nil

        try super.tearDownWithError()
    }

    func testGetIncidents() async throws {
        let _ = try await testSubject.fetchIncidents()

        let expectedData = [
            Incident(
                title: "Ambulance Response - GREENWAY",
                callTime: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                id: "038693-06072022",
                latitude: -35.411775,
                longitude: 149.06496796,
                description: nil,
                location: "GREENWAY",
                status: Incident.StatusType.pending,
                type: "Ambulance Response",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "MVA - Dangar Islan",
                callTime: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                id: "incidents_458354",
                latitude: -33.539702,
                longitude: 151.242673,
                description: "Road traffic accident - 1 trapped\n2 Crews Responding",
                location: "Grantham Cr, Dangar Island, NSW 2083",
                status: Incident.StatusType.outOfControl,
                type: "MVA/Transport",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "Bush Fire - Tocumwal",
                callTime: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                id: "incidents_458325",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "Bush fire under control\n4 Crews On Scene",
                location: "Crothers Rd, Tocumwal, NSW 2714",
                status: Incident.StatusType.underControl,
                type: "Bush Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "House Fire - WATSON",
                callTime: Formatter.formattedDate(from: "2022-07-04T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-04-06T12:03:25+1000"),
                id: "010017-06072022",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "House fire",
                location: "DOWLING STREET, WATSON, 2602",
                status: Incident.StatusType.onScene,
                type: "House Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            )
        ]
        
        XCTAssertEqual(testSubject.state, .loaded)
        XCTAssertEqual(testSubject.incidents, expectedData)
    }
    
    func testSortedIncidents() {
        testSubject.incidents = [
            Incident(
                title: "Ambulance Response - GREENWAY",
                callTime: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                id: "038693-06072022",
                latitude: -35.411775,
                longitude: 149.06496796,
                description: nil,
                location: "GREENWAY",
                status: Incident.StatusType.pending,
                type: "Ambulance Response",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "MVA - Dangar Islan",
                callTime: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                id: "incidents_458354",
                latitude: -33.539702,
                longitude: 151.242673,
                description: "Road traffic accident - 1 trapped\n2 Crews Responding",
                location: "Grantham Cr, Dangar Island, NSW 2083",
                status: Incident.StatusType.outOfControl,
                type: "MVA/Transport",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "Bush Fire - Tocumwal",
                callTime: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                id: "incidents_458325",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "Bush fire under control\n4 Crews On Scene",
                location: "Crothers Rd, Tocumwal, NSW 2714",
                status: Incident.StatusType.underControl,
                type: "Bush Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "House Fire - WATSON",
                callTime: Formatter.formattedDate(from: "2022-07-04T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-04-06T12:03:25+1000"),
                id: "010017-06072022",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "House fire",
                location: "DOWLING STREET, WATSON, 2602",
                status: Incident.StatusType.onScene,
                type: "House Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            )
        ]
        testSubject.sortIncidents(isDescending: false)
        
        let expectedData = [
            Incident(
                title: "Ambulance Response - GREENWAY",
                callTime: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-09-06T12:03:25+1000"),
                id: "038693-06072022",
                latitude: -35.411775,
                longitude: 149.06496796,
                description: nil,
                location: "GREENWAY",
                status: Incident.StatusType.pending,
                type: "Ambulance Response",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "MVA - Dangar Islan",
                callTime: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-08-06T12:03:25+1000"),
                id: "incidents_458354",
                latitude: -33.539702,
                longitude: 151.242673,
                description: "Road traffic accident - 1 trapped\n2 Crews Responding",
                location: "Grantham Cr, Dangar Island, NSW 2083",
                status: Incident.StatusType.outOfControl,
                type: "MVA/Transport",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "Bush Fire - Tocumwal",
                callTime: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-07-06T12:03:25+1000"),
                id: "incidents_458325",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "Bush fire under control\n4 Crews On Scene",
                location: "Crothers Rd, Tocumwal, NSW 2714",
                status: Incident.StatusType.underControl,
                type: "Bush Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            ),
            Incident(
                title: "House Fire - WATSON",
                callTime: Formatter.formattedDate(from: "2022-07-04T12:03:25+1000"),
                lastUpdated: Formatter.formattedDate(from: "2022-04-06T12:03:25+1000"),
                id: "010017-06072022",
                latitude: -35.7784569999999,
                longitude: 145.635167,
                description: "House fire",
                location: "DOWLING STREET, WATSON, 2602",
                status: Incident.StatusType.onScene,
                type: "House Fire",
                typeIcon: URL(string: "https://i.imgur.com/I.png")!
            )
        ]
        
        XCTAssertEqual(testSubject.incidents, expectedData.reversed())
    }

}
