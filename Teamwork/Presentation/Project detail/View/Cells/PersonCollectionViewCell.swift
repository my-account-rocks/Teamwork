//
//  PersonCollectionViewCell.swift
//  Teamwork
//
//  Created by Pedro on 12/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.layer.cornerRadius = icon.frame.width / 2.0
            icon.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var name: UILabel!
}
