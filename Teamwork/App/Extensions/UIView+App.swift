//
//  UIView+App.swift
//  Teamwork
//
//  Created by Pedro on 12/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else { return }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }

    static var customNibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    static func loadFromNib<T: UIView>() -> T {
        guard let nib = UINib(nibName: customNibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
            else {
                fatalError("Could not awake from nib")
        }
        return nib
    }
}
