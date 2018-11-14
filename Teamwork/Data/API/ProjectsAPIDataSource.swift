//
//  ProjectsApiDataSource.swift
//  Teamwork
//
//  Created by Pedro on 10/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation
import Alamofire

private let getProjectsPath = "/projects/api/v2/projects.json"
private let includeTopPeopleParam = "includeTopPeople"

enum ProjectsEndpoint {
    case getProjects(Bool)
}

extension ProjectsEndpoint: Request {
    var method: HTTPMethod {
        switch self {
        case .getProjects:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getProjects:
            return getProjectsPath
        }
    }

    var parameters: Parameters {
        switch self {
        case .getProjects(let includeTopPeople):
            return [includeTopPeopleParam: includeTopPeople]
        }
    }
}

class ProjectsAPIDataSource: ProjectsDataSourceProtocol {
    let api: APIClient

    init(apiClient: APIClient) {
        self.api = apiClient
    }

    func getProjects(includeTopPeople: Bool, completion: @escaping GetProjectsClosure) {
        api.request(with: ProjectsEndpoint.getProjects(includeTopPeople)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.teamwork)
                    let projectsResponse = try decoder.decode(ProjectsResponse.self, from: data)
                    completion(.success(projectsResponse.projects))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
