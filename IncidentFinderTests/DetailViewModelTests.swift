//
//  DetailViewModelTests.swift
//  IncidentFinderTests
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import XCTest
@testable import IncidentFinder

final class DetailViewModelTests: XCTestCase {
    
    private var testSubject: DetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        let incident = Incident(
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
            typeIcon: URL(string: "https://i.imgur.com/IUwhSWJ.png")!
        )
        let imageCache = ImageCache()
        testSubject = DetailViewModel(
            incident: incident,
            imageCache: imageCache
        )
    }

    override func tearDownWithError() throws {
        testSubject = nil

        try super.tearDownWithError()
    }

    func testDetails() throws {
        XCTAssertEqual(testSubject.title, "Ambulance Response - GREENWAY")
        XCTAssertEqual(testSubject.location.latitude, -35.411775)
        XCTAssertEqual(testSubject.location.longitude, 149.06496796)
    }

}
