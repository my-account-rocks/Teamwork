//
//  Assembly.swift
//  heroes.me
//
//  Created by Pedro Cabrera on 24/7/17.
//  Copyright © 2017 Pedro Cabrera Rodríguez. All rights reserved.
//

import Foundation

struct Assembly {
    fileprivate static let instance = Assembly()
    let api = APIClient()

    /**
     Prevent default initializer
     */
    private init() {}
}

func assembler() -> Assembly {
    return Assembly.instance
}
