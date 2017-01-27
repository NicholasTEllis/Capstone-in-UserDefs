//
//  Person.swift
//  PairNSUserDefaults
//
//  Created by Nicholas Ellis on 1/26/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class Person {
    
    fileprivate static let kName = "name"
    let name: String
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary[Person.kName] as? String
            else {return nil}
        self.name = name
    }
    
    var dictionaryRepresentation: [String : Any] {
        return [Person.kName : self.name]
    }
}
