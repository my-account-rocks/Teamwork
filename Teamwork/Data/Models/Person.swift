//
//  Person.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

internal struct OwnProfileResponse: Codable {
    let person: OwnProfile
}

internal struct OwnProfile: Codable {
    let id: String
    let avatarUrl: URL?
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar-url"
        case firstName = "last-name"
        case lastName = "first-name"
    }

    var person: Person {
        return Person(id: Int(id) ?? -1, avatarUrl: avatarUrl, firstName: firstName, lastName: lastName)
    }
}

struct Person: Codable {
    let id: Int
    let avatarUrl: URL?
    let firstName: String
    let lastName: String
}
