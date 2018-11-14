//
//  ProjectsViewControllerAssembly.swift
//  
//
//  Created by Pedro on 9/11/18.
//

import Foundation
import UIKit

extension Assembly {
    func provideProjectsNavigationController() -> UIViewController {
        let viewController = assembler().provideProjectsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = .main
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        return navigationController
    }

    func provideProjectsViewController() -> ProjectsViewController {
        let projectsDataSource = assembler().provideProjectsDataSource()
        let poepleDataSource = assembler().providePeopleDataSource()
        let presenter = ProjectsPresenter(projectsDataSource: projectsDataSource,
                                          peopleDataSource: poepleDataSource)
        let viewController = ProjectsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
