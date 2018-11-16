//
//  Person.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
