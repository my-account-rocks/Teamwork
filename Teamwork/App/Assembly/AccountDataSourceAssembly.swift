//
//  PeopleDataSourceAssembly.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

extension Assembly {
    func providePeopleDataSource() -> PeopleDataSourceProtocol {
        return PeopleAPIDataSource(apiClient: api)
    }
}
