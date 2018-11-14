//
//  ProjectDetailPresenter.swift
//  Teamwork
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

protocol ProjectDetailUI: class {
    func add(imageURL: URL)
    func add(people: [Person])
    func add(title: String, subtitle: String)
    func add(description: String)
    func add(startDate: String, endDate: String)
    func render()
}

class ProjectDetailPresenter {

    weak var view: ProjectDetailUI?
    private let project: Project
    private let dateFormatter: DateFormatter

    init(project: Project, dateFormatter: DateFormatter) {
        self.project = project
        self.dateFormatter = dateFormatter
    }

    func viewDidLoad() {
        if let logo = project.logo {
            view?.add(imageURL: logo)
        }
        view?.add(title: project.name, subtitle: project.company.name)

        let startDate = dateFormatter.string(from: project.startDate)
        let endDate = dateFormatter.string(from: project.endDate)

        view?.add(startDate: startDate, endDate: endDate)
        if let description = project.description {
            view?.add(description: description)
        }
        if let people = project.people {
            view?.add(people: people)
        }
        view?.render()
    }
}
