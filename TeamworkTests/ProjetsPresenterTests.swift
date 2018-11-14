//
//  TeamworkTests.swift
//  TeamworkTests
//
//  Created by Pedro on 8/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import XCTest
@testable import Teamwork

private class ViewSpy: ProjectsUI {
    func navigateTo(project: Project) {}

    var startLoadingStateCalled = false
    var showErrorStateCalled = false
    var showProjectsCalled = false
    var showAccountCalled = false

    var showErrorStateClosure: (() -> Void)?
    var showProjectsClosure: (() -> Void)?
    var showAccountClosure: (() -> Void)?

    func startLoadingState() {
        startLoadingStateCalled = true
    }

    func showErrorState() {
        showErrorStateCalled = true
        showErrorStateClosure?()
    }

    func show(projects: [Project]) {
        showProjectsCalled = true
        showProjectsClosure?()
    }

    func show(account: Person) {
        showAccountCalled = true
        showAccountClosure?()

    }
}

class ProjectsPresenterTests: XCTestCase {

    func testSuccessScenarioCalledTheRightsMethods() {
        let project = ProjectMother.deathStar.project
        let account = AccountMother.pedro.account

        let peopleDataSourceMock = PeopletDataSourceMock(resultToReturn: .success(account))
        let projectsDataSourceMock = ProjectsDataSourceMock(resultToReturn: .success([project]))
        let sut = ProjectsPresenter(projectsDataSource: projectsDataSourceMock,
                                    peopleDataSource: peopleDataSourceMock)

        let projectsExp = expectation(description: "Projects expectation")
        let accountExp = expectation(description: "Account expectation")
        let viewSpy = ViewSpy()
        viewSpy.showAccountClosure = {
            accountExp.fulfill()
        }
        viewSpy.showProjectsClosure = {
            projectsExp.fulfill()
        }

        sut.view = viewSpy
        sut.viewDidLoad()

        wait(for: [accountExp, projectsExp], timeout: 1)

        XCTAssertTrue(viewSpy.startLoadingStateCalled, "Spinner should have been shown")
        XCTAssertTrue(viewSpy.showAccountCalled, "Account info should have been shown")
        XCTAssertTrue(viewSpy.showProjectsCalled, "Projects info should have been shown")
        XCTAssertFalse(viewSpy.showErrorStateCalled, "No errors happened")
    }

}
