//
//  ProjectDetailAssembly.swift
//  Teamwork
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

extension Assembly {
    func provideProjectDetailViewController(with project: Project) -> ProjectDetailViewController {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let presenter = ProjectDetailPresenter(project: project, dateFormatter: dateFormatter)
        let viewController = ProjectDetailViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
