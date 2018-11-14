//
//  ProjectsViewController.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit
import SDWebImage

class ProjectsViewController: UIViewController {

    private let presenter: ProjectsPresenter
    private var projects = [Project]()
    private var account: Person?

    private let cellID = "ProjectCell"
    @IBOutlet weak private var spinner: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "ProjectTableViewCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: cellID)
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.estimatedRowHeight = 100
        }
    }
    @IBOutlet weak private var errorMsg: UILabel!

    init(presenter: ProjectsPresenter) {
        self.presenter = presenter
        super.init(nibName: "ProjectsViewController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ProjectsViewController: ProjectsUI {

    func startLoadingState() {
        spinner.startAnimating()
    }

    func showErrorState() {
        errorMsg.isHidden = false
        tableView.isHidden = true
        spinner.isHidden = true
    }

    func show(projects: [Project]) {
        self.projects = projects
        spinner.isHidden = true
        tableView.reloadData()
    }

    func show(account: Person) {
        self.account = account
        //title
        navigationItem.title = account.firstName + " " + account.lastName
        //avatar
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageview.layer.cornerRadius = 15
        imageview.layer.masksToBounds = true
        imageview.sd_setImage(with: account.avatarUrl)
        containView.addSubview(imageview)
        let rightBarButton = UIBarButtonItem(customView: containView)
        navigationItem.rightBarButtonItem = rightBarButton
    }

    func navigateTo(project: Project) {
        let projectDetailVC = assembler().provideProjectDetailViewController(with: project)
        navigationController?.pushViewController(projectDetailVC, animated: true)

    }
}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                       for: indexPath) as? ProjectTableViewCell else {
                                                        fatalError()
        }
        let project = projects[indexPath.row]
        cell.setUp(with: project)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.requestNavigationTo(project: projects[indexPath.row])
    }

}
