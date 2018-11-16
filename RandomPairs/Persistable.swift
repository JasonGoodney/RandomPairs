//
//  Persistable.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

protocol Persistable {
    associatedtype T: Codable
    
    func saveToPersistance(_ items: T)
    func loadFromPersistance() -> T?
}

extension Persistable {
    
    func saveToPersistance(_ items: T) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL())
        } catch let error {
            print("🎅🏻\nThere was an error in \(#function): \(error)\n\n\(error.localizedDescription)\n🎄")
        }
    }
    
    
    func loadFromPersistance() -> T? {
        do {
            let data = try Data(contentsOf: fileURL())
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch let error {
            print("🎅🏻\nThere was an error in \(#function): \(error)\n\n\(error.localizedDescription)\n🎄")
        }
        
        return nil
    }
    
    private func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = String(describing: T.self) + ".json"
        let documentDirectoryURL = paths[0].appendingPathComponent(fileName)
        return documentDirectoryURL
    }
}
