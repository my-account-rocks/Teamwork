//
//  ProjectsService.swift
//  TeamworkTests
//
//  Created by Pedro on 10/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Teamwork

class ProjectsAPIDataSourceTest: XCTestCase {

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }

    func testGivenACorrectJSONThePlansAreParsedSuccessfully() {
        stub(condition: isPath("/projects/api/v2/projects.json")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("Projects.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let api = APIClient()
        let sut = ProjectsAPIDataSource(apiClient: api)
        let exp = expectation(description: "Get projects expectation")
        sut.getProjects(includeTopPeople: true) { result in
            exp.fulfill()
            switch result {
            case .success(let projects):
                XCTAssertEqual(projects.count, 2, "Incorrect number of projects")
                XCTAssertEqual(projects[0].name, "Brazil", "Incorrect project name")
                XCTAssertEqual(projects[1].name, "Time Machine R&D", "Incorrect project name")
            case .failure:
                XCTFail("The data should have been parsed succesfully")
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func testGivenErrorResponseAnErrorIsReturned() {
        stub(condition: isPath("/projects/api/v2/projects.json")) { _ in
            let notConnectedError = NSError(domain: "tests.domain", code: 500, userInfo: nil)
            return OHHTTPStubsResponse(error: notConnectedError)
        }

        let api = APIClient()
        let sut = ProjectsAPIDataSource(apiClient: api)
        let exp = expectation(description: "Get projects expectation")
        sut.getProjects(includeTopPeople: true) { result in
            exp.fulfill()
            switch result {
            case .success:
                XCTFail("The data should have been parsed succesfully")
            case .failure:
                break
            }
        }
        wait(for: [exp], timeout: 1)
    }

}
