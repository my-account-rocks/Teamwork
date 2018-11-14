//
//  Project.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

internal struct ProjectsResponse: Codable {
    let projects: [Project]
}

struct Project: Codable {
    let id: Int
    let name: String
    let description: String?
    let company: Company
    let startDate: Date
    let endDate: Date
    let logo: URL?
    let people: [Person]?
}

struct Company: Codable {
    let id: Int
    let name: String
}

extension DateFormatter {
    static let teamwork: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
