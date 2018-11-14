//
//  APIClient.swift
//  Teamwork
//
//  Created by Pedro on 10/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Alamofire
import Foundation

enum APIClientError: Error {
    case noParseable
    case networkError
}

protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
}

class APIClient {
    let host = "https://yat.teamwork.com"
    let authHeaders: HTTPHeaders

    init() {
        let user = "yat@triplespin.com"
        let password = "yatyatyat27"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        self.authHeaders = headers
    }

    func request(with resource: Request, completion: @escaping (Result<Data>) -> Void) {
        Alamofire.request(host + resource.path,
                          method: resource.method,
                          parameters: resource.parameters,
                          headers: authHeaders).validate().responseData { response in
                            switch response.result {
                            case .success(let data):
                                completion(.success(data))
                            case .failure:
                                completion(.failure(APIClientError.networkError))
                            }
        }
    }
}
