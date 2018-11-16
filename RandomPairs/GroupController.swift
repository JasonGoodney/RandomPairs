//
//  GroupController.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

class GroupController: Persistable {
    
    typealias T = [Person]
    
    static let shared = GroupController(); private init() {}
    
    var people: [Person] = [] {
        didSet {
            // Regroup when people changes (added, removed, or shuffled)
            group()
        }
    }
    
    var groups: [Group] = []
    
    func load() {
        guard let people = loadFromPersistance() else { return }
        self.people = people
    }
    
    func add(_ person: Person) {
        people.append(person)
        saveToPersistance(people)
    }
    
    func remove(_ person: Person) {
        people.removeAll(where:  { $0 == person })
        saveToPersistance(people)
    }
    
    func removeAll() {
        people = []
        saveToPersistance(people)
    }
    
    // A temporary array of people to mutate in size until size is zero
    // Makes sure no person in repeated in the shuffling
    func shuffle() {
        var temp = people
        var shuffledPeople: [Person] = []
        
        for _ in 0..<temp.count {
            let randomIndex = Int(arc4random_uniform(UInt32(temp.count)))
            shuffledPeople.append(temp[randomIndex])
            temp.remove(at: randomIndex)
        }
        
        people = shuffledPeople
        saveToPersistance(shuffledPeople)
    }
    
    // Creates a new group of people of each adjacent pair
    func group() {
        groups = []
        
        for i in stride(from: 0, to: people.count, by: 2) {
            let person1 = people.indices.contains(i) ? people[i] : nil
            let person2 = people.indices.contains(i + 1) ? people[i + 1] : nil
            
            let group = Group(person1: person1, person2: person2)
            groups.append(group)
        }
    }
}
