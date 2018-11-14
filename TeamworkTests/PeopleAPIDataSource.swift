//
//  AccountAPIDataSource.swift
//  TeamworkTests
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Teamwork

class AccountAPIDataSourceTest: XCTestCase {
    override func setUp() {
        stub(condition: isPath("/me.json")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("Person.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }

    func testGivenACorrectJSONTheAccountIsParsedSuccessfully() {
        let api = APIClient()
        let sut = PeopleAPIDataSource(apiClient: api)
        let exp = expectation(description: "Get account expectation")
        sut.getCurrentAccount { result in
            exp.fulfill()
            switch result {
            case .success(let person):
                XCTAssertEqual(person.id, 999, "Incorrect account id")
                XCTAssertEqual(person.firstName, "User", "Incorrect account name")
                XCTAssertEqual(person.lastName, "Demo", "Incorrect account company name")
            case .failure:
                XCTFail("The data should have been parsed succesfully")
            }
        }
        wait(for: [exp], timeout: 10)
    }
}
