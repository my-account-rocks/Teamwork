//
//  HeroesPresenter.swift
//  heroes.me
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

protocol ProjectsUI: class {
    func startLoadingState()
    func showErrorState()
    func show(projects: [Project])
    func show(account: Person)
    func navigateTo(project: Project)
}

class ProjectsPresenter {
    weak var view: ProjectsUI?
    private let projectsDataSource: ProjectsDataSourceProtocol
    private let peopleDataSource: PeopleDataSourceProtocol

    init(projectsDataSource: ProjectsDataSourceProtocol,
         peopleDataSource: PeopleDataSourceProtocol) {
        self.projectsDataSource = projectsDataSource
        self.peopleDataSource = peopleDataSource
    }

    func viewDidLoad() {
        self.fetchProjects()
        self.fetchAccount()
    }

    func fetchProjects() {
        view?.startLoadingState()
        projectsDataSource.getProjects(includeTopPeople: true) { [weak self] result in
            switch result {
            case .success(let projects):
                self?.view?.show(projects: projects)
            case .failure:
                self?.view?.showErrorState()
            }
        }
    }

    func fetchAccount() {
        peopleDataSource.getCurrentAccount { [weak self] result in
            switch result {
            case .success(let account):
                self?.view?.show(account: account)
            case .failure:
                break
            }
        }
    }

    func requestNavigationTo(project: Project) {
        self.view?.navigateTo(project: project)
    }

}
