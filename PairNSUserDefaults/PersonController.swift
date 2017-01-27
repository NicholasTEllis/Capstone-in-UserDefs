//
//  PersonController.swift
//  PairNSUserDefaults
//
//  Created by Nicholas Ellis on 1/26/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import GameKit

class PersonController {
    
    fileprivate static let kPerson = "person"
    
    static let sharedController = PersonController()
    var persons: [Person] = []
    var pairsOfPersons: [[Person]] {
        return randomizer(people: persons)
    }
    
    init() {
        loadFromStorage()
    }
    
    func add(personNamed name: String) {
        let person = Person(name: name)
        persons.append(person)
        savedToStorage()
    }
    
    func savedToStorage() {
        let userDefaults = UserDefaults.standard
        let personDictionaries = persons.map({$0.dictionaryRepresentation})
        
        userDefaults.set(personDictionaries, forKey: PersonController.kPerson)
    }
    
    func loadFromStorage() {
        let userDefaults = UserDefaults.standard
        guard let personDictionary = userDefaults.object(forKey: PersonController.kPerson) as? [[String : Any]]
            else { return }
        persons = personDictionary.flatMap({Person(dictionary: $0)})
    }

    func randomizer(people: [Person]) -> [[Person]] {
        let randomGenerator = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: persons)
        let splitSize = 2
        let people = stride(from: 0, to: randomGenerator.count, by: splitSize).map {
            Array(people[$0..<min($0 + splitSize, people.count)])
        }
      return people
    }
}



