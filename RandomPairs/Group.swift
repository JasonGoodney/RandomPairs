//
//  Group.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

class Group {
    
    private let person1: Person?
    private let person2: Person?
    
    // If both people are nil, returns empty array
    // If only one person is set, returns array of 1
    // If both people are set, returns a pair of people
    var members: [Person] {
        var returnValue: [Person] = []
        
        guard let person1 = person1 else { return returnValue }
        returnValue.append(person1)
        
        guard let person2 = person2 else { return returnValue }
        returnValue.append(person2)
        
        return returnValue
    }
    
    init(person1: Person? = nil, person2: Person? = nil) {
        self.person1 = person1
        self.person2 = person2
    }
}
