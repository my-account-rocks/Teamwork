//
//  Entity.swift
//  Teamwork
//
//  Created by Pedro on 9/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}
