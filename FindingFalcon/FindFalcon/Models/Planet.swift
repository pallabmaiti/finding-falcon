//
//  Planet.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

struct Planet: Equatable, Hashable {
    let name: String
    let distance: Int
    var selected = false
}

extension Planet {
    static var dummy: Self {
        return Planet(name: "Select", distance: 0)
    }
}
