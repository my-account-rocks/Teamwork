//
//  TestHelpers.swift
//  TeamworkTests
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation
@testable import Teamwork

enum AccountMother {
    case pedro
    case mike
    case jobs

    var account: Person {
        switch self {
        case .pedro:
            return Person(id: 1, avatarUrl: nil, firstName: "Pedro", lastName: "Coolcompany")
        case .mike:
            return Person(id: 2, avatarUrl: nil, firstName: "Mike", lastName: "Coolcompany2")
        case .jobs:
            return Person(id: 3, avatarUrl: nil, firstName: "Steve", lastName: "Apple")
        }
    }
}

enum PeopleMother {
    case pedro
    case jobs

    var person: Person {
        switch self {
        case .pedro:
            return Person(id: 1, avatarUrl: nil, firstName: "Pedro", lastName: "Cabrera")
        case .jobs:
            return Person(id: 2, avatarUrl: nil, firstName: "Steve", lastName: "Jobs")
        }
    }
}

enum CompanyMother {
    case teamwork

    var company: Company {
        switch self {
        case .teamwork:
            return Company(id: 1, name: "Teamwork")
        }
    }
}

enum ProjectMother {
    case delorean
    case deathStar

    var project: Project {
        switch self {
        case .delorean:
            return Project(id: 1,
                           name: "Delorean",
                           description: "Create a car to travel to the past",
                           company: CompanyMother.teamwork.company,
                           startDate: Date(),
                           endDate: Date(),
                           logo: URL(string: "http://mylogo.png"),
                           people: [PeopleMother.jobs.person])
        case .deathStar:
            return Project(id: 2,
                           name: "Death Star",
                           description: nil,
                           company: CompanyMother.teamwork.company,
                           startDate: Date(),
                           endDate: Date(),
                           logo: nil,
                           people: nil)
        }
    }
}

class PeopletDataSourceMock: PeopleDataSourceProtocol {
    var resultToReturn: Result<Person>

    init(resultToReturn: Result<Person>) {
        self.resultToReturn = resultToReturn
    }

    func getCurrentAccount(completion: @escaping GetPersonClosure) {
        completion(resultToReturn)
    }
}

class ProjectsDataSourceMock: ProjectsDataSourceProtocol {
    var resultToReturn: Result<[Project]>

    init(resultToReturn: Result<[Project]>) {
        self.resultToReturn = resultToReturn
    }

    func getProjects(includeTopPeople: Bool, completion: @escaping GetProjectsClosure) {
        completion(resultToReturn)
    }
}
