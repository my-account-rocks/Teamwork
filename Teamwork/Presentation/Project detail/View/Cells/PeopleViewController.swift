//
//  PeopleViewController.swift
//  Teamwork
//
//  Created by Pedro on 12/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    private let people: [Person]

    private let cellID = "PersonCollectionViewCell"
    @IBOutlet weak private var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "PersonCollectionViewCell", bundle: nil)
            self.collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        }
    }

    init(people: [Person]) {
        self.people = people
        super.init(nibName: "PeopleViewController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PeopleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                      for: indexPath) as? PersonCollectionViewCell else {
                                                        fatalError()
        }
        let person = people[indexPath.row]
        cell.name.text = person.firstName
        cell.icon.sd_setImage(with: person.avatarUrl)
        return cell
    }
}
