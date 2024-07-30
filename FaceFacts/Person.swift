//
//  Person.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import Foundation
import SwiftData

//data model for Person 
@Model
class Person {
    var name: String
    var emailAddress: String
    var details: String
    
    init(name: String, emailAddress: String, details: String) {
        self.name = name
        self.emailAddress = emailAddress
        self.details = details
    }
}
