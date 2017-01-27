//
//  PersonTableViewController.swift
//  PairNSUserDefaults
//
//  Created by Nicholas Ellis on 1/26/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import GameKit

class PersonTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (PersonController.sharedController.pairsOfPersons.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.sharedController.pairsOfPersons[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.sharedController.pairsOfPersons[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var personNameTextFieled: UITextField?
        let alert = UIAlertController(title: "Enter Full Name", message: "Pair Randomizer", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Full Name.."
            personNameTextFieled = textField
        }
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {
            (textField) in
            guard let nameText = personNameTextFieled?.text else { return }
            PersonController.sharedController.add(personNamed: nameText)
            self.tableView.reloadData()
            
        })
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    func randomize() {
        PersonController.sharedController.persons.shuffle()
        tableView.reloadData()
    }

    @IBAction func randomizeButtonTapped(_ sender: Any) {
        randomize()
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
