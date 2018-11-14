//
//  ProjectsDataSource.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

typealias GetProjectsClosure = (Result<[Project]>) -> Void

protocol ProjectsDataSourceProtocol {
    func getProjects(includeTopPeople: Bool, completion: @escaping GetProjectsClosure)
}
