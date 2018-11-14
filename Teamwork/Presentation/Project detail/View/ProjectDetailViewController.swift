//
//  ProjectDetailViewController.swift
//  Teamwork
//
//  Created by Pedro on 11/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit
import SDWebImage

class ProjectDetailViewController: UIViewController {
    private let presenter: ProjectDetailPresenter
    private var cells = [UITableViewCell]()
    private var peopleViewController: PeopleViewController?

    private let cellID = "ProjectDetailCell"
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            self.tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.estimatedRowHeight = 100
        }
    }

    init(presenter: ProjectDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: "ProjectDetailViewController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ProjectDetailViewController: ProjectDetailUI {
    func add(description: String) {
        let descrptionView: DescriptionView = DescriptionView.loadFromNib()
        let cell = CustomViewCell(customView: descrptionView, reuseIdentifier: DescriptionView.customNibName)
        descrptionView.descriptionLabel.text = description
        cells.append(cell)
    }

    func add(title: String, subtitle: String) {
        self.navigationItem.title = title
    }

    func add(imageURL: URL) {
        let logoView: LogoView = LogoView.loadFromNib()
        logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor, multiplier: 3.0/4.0).isActive = true
        let cell = CustomViewCell(customView: logoView, reuseIdentifier: LogoView.customNibName)
        logoView.logo.sd_setImage(with: imageURL)
        cells.append(cell)
    }

    func add(people: [Person]) {
        peopleViewController = PeopleViewController(people: people)
        let cell = CustomViewCell(customView: peopleViewController!.view, reuseIdentifier: DatesView.customNibName)
        cells.append(cell)
    }

    func add(startDate: String, endDate: String) {
        let datesView: DatesView = DatesView.loadFromNib()
        let cell = CustomViewCell(customView: datesView, reuseIdentifier: DatesView.customNibName)
        datesView.startDate.text = startDate
        datesView.endDate.text = endDate
        cells.append(cell)
    }

    func render() {
        tableView.reloadData()
    }
}

extension ProjectDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        return cell
    }
}
