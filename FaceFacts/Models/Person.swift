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
    var metAt: Event?
    //@Attribute(.externalStorage) - to ask swiftdata to not store this in swiftdata db and store it at an external location
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, emailAddress: String, details: String, metAt: Event? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.details = details
        self.metAt = metAt
    }
}
