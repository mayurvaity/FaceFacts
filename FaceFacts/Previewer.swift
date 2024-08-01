//
//  Previewer.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 01/08/24.
//

import Foundation
import SwiftData

//below struct is for previews 

//need to run as MainActor, w/o it we cannot access below properties in the app easily
@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        //to not write this data to disk
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        //creating container obj
        container = try ModelContainer(for: Person.self, configurations: config)
        
        //creating event and person
        event = Event(name: "Dimension Jump", location: "Nottingham")
        person = Person(name: "Dave Lister", emailAddress: "dave@reddwarf.com", details: "", metAt: event)
        
        //finally adding abv created person data to swiftdata (one that's stored on the RAM, not the Original one)
        //we r not adding event separately as it will automatically add event with this person obj
        container.mainContext.insert(person)
    }
}


