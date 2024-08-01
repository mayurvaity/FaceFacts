//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import SwiftData
import SwiftUI

struct EditPersonView: View {
    //accessing model context
    @Environment(\.modelContext) var modelContext
    
    @Bindable var person: Person
    
    @Binding var navigationPath: NavigationPath
    
    //creating query to get events data from swiftdata db,
    //also sorting event data 1st by name and then by location
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Where did you meet them?") {
                //tag - value of tag get assigned to person.metAt, when that option is selected
                Picker("Met at", selection: $person.metAt) {
                    //default event value
                    Text("Unknown event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        //to put a line in dropdown menu in between default val and below ones
                        Divider()
                        
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(event)
                        }
                    }
                }
                
                Button("Add a new event", action: addEvent)
            }
            
            Section("Notes") {
                //axis: .vertical - to specify that this field will grow vertically 
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            //calling vw to edit this event
            EditEventView(event: event)
        }
    }
    
    //fn to create a new blank event
    func addEvent() {
        //creating a blank event
        let event = Event(name: "", location: "")
        //adding this to the modelcontext
        modelContext.insert(event)
        //sending event value with nav path back to the content vw
        navigationPath.append(event)
    }
}

//#Preview {
//    EditPersonView()
//}
