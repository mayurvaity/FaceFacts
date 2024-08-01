//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import SwiftData
import SwiftUI
import PhotosUI

struct EditPersonView: View {
    //accessing model context
    @Environment(\.modelContext) var modelContext
    
    @Bindable var person: Person
    
    @Binding var navigationPath: NavigationPath
    //var to shows photos
    @State private var selectedItem: PhotosPickerItem?
    
    //creating query to get events data from swiftdata db,
    //also sorting event data 1st by name and then by location
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                //if photo Data is avlbl in person obj
                //and that Data can be converted into a UIImage format then show the image
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                //photo picker in the form
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            
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
        //when a diffnt photo is selected by photopicker abv, below fn will run to load that photo from storage to here
        .onChange(of: selectedItem) {
            loadPhoto()
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
    
    //to get photo from storage whenever a diffnt photo is selected
    func loadPhoto() {
        Task { @MainActor in
            //to get photo from selectedItem, convert it into Data format and add to the person obj
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

//#Preview {
//    EditPersonView(person: try! Previewer().person, navigationPath: .constant(NavigationPath()))
//        .modelContainer(try! Previewer().container)
//}
