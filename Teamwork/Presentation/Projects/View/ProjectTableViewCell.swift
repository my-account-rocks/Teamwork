//
//  ProjectTableViewCell.swift
//  Teamwork
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
}

extension ProjectTableViewCell {
    func setUp(with project: Project) {
        name.text = project.name
        companyName.text = project.company.name
        projectDescription.text = project.description
    }
}
