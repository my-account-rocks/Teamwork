//
//  ProjectDetailTests.swift
//  TeamworkTests
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

import XCTest
@testable import Teamwork

private class ViewSpy: ProjectDetailUI {
    func add(imageURL: URL) {
        addImageCalled = true
    }

    func add(people: [Person]) {
        addPeopleCalled = true
    }

    func add(title: String, subtitle: String) {
        addTitleAndSubtitleCalled = true
    }

    func add(description: String) {
        addDescriptionCalled = true
    }

    func add(startDate: String, endDate: String) {
        addDatesCalled = true
    }

    func render() {
        renderCalled = true
    }

    var addImageCalled = false
    var addPeopleCalled = false
    var addDescriptionCalled = false
    var addTitleAndSubtitleCalled = false
    var addDatesCalled = false
    var renderCalled = false

}

class ProjectDetailPresenterTests: XCTestCase {

    func testSuccessScenarioCalledTheRightsMethods() {
        let project = ProjectMother.delorean.project
        let sut = ProjectDetailPresenter(project: project, dateFormatter: DateFormatter())
        let viewSpy = ViewSpy()
        sut.view = viewSpy

        sut.viewDidLoad()

        XCTAssertTrue(viewSpy.addImageCalled, "Image should have been added")
        XCTAssertTrue(viewSpy.addPeopleCalled, "People should have been added")
        XCTAssertTrue(viewSpy.addDescriptionCalled, "Description should have been added")
        XCTAssertTrue(viewSpy.addTitleAndSubtitleCalled, "Title should have been added")
        XCTAssertTrue(viewSpy.addDatesCalled, "Dates should have been added")
        XCTAssertTrue(viewSpy.renderCalled, "View should have been rendered")
    }

    func testProjectWithMissingDateCalledTheRightMethods() {
        let project = ProjectMother.deathStar.project
        let sut = ProjectDetailPresenter(project: project, dateFormatter: DateFormatter())
        let viewSpy = ViewSpy()
        sut.view = viewSpy

        sut.viewDidLoad()

        XCTAssertFalse(viewSpy.addImageCalled, "Image should have been shown")
        XCTAssertFalse(viewSpy.addPeopleCalled, "People should have been shown")
        XCTAssertFalse(viewSpy.addDescriptionCalled, "Description should have been shown")
        XCTAssertTrue(viewSpy.addTitleAndSubtitleCalled, "Title should have been shown")
        XCTAssertTrue(viewSpy.addDatesCalled, "Dates should have been shown")
    }

}
