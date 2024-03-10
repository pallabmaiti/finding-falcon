//
//  Vehicle.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 04/03/24.
//

import Foundation

struct Vehicle: Equatable, Hashable {
    let name: String
    var totalNo: Int
    let maxDistance: Int
    let speed: Int
    var selected: Bool = false
}
