//
//  PeopleDataSource.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

typealias GetPersonClosure = (Result<Person>) -> Void

protocol PeopleDataSourceProtocol {
    func getCurrentAccount(completion: @escaping GetPersonClosure)
}
