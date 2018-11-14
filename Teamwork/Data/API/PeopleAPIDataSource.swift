//
//  PeopleApiDataSource.swift
//  Teamwork
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

import Alamofire

private let accounntPath = "/me.json"

enum PeopleEndpoint {
    case getCurrentAccount
}

extension PeopleEndpoint: Request {
    var method: HTTPMethod {
        switch self {
        case .getCurrentAccount:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getCurrentAccount:
            return accounntPath
        }
    }

    var parameters: Parameters {
        switch self {
        case .getCurrentAccount:
            return [:]
        }
    }
}

class PeopleAPIDataSource: PeopleDataSourceProtocol {
    let api: APIClient

    init(apiClient: APIClient) {
        self.api = apiClient
    }

    func getCurrentAccount(completion: @escaping GetPersonClosure) {
        api.request(with: PeopleEndpoint.getCurrentAccount) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let currentAccountResponse = try decoder.decode(OwnProfileResponse.self, from: data)
                    completion(.success(currentAccountResponse.person.person))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
