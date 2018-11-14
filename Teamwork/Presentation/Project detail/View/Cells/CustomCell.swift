//
//  CustomCell.swift
//  Teamwork
//
//  Created by Pedro on 12/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    init(customView: UIView, reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(customView)
        customView.bindFrameToSuperviewBounds()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
