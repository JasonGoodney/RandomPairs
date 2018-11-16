//
//  ViewController.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellId = "NameCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupController.shared.load()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func shuffleButtonTapped(_ sender: Any) {
        GroupController.shared.shuffle()
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddPersonAlert(withTitle: "Add Person", message: "") { (person) in
            guard let person = person else { return }
            GroupController.shared.add(person)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func removeAllButtonTapped(_ sender: Any) {
        GroupController.shared.removeAll()
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return GroupController.shared.groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = GroupController.shared.groups[section]
        return group.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let group = GroupController.shared.groups[indexPath.section]
        let person = group.members[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = GroupController.shared.groups[indexPath.section]
            let person = group.members[indexPath.row]
            
            GroupController.shared.remove(person)
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
}

