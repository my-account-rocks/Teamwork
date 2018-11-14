//
//  ProjectsDataSourceAssembly.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

extension Assembly {
    func provideProjectsDataSource() -> ProjectsDataSourceProtocol {
        return ProjectsAPIDataSource(apiClient: api)
    }
}
