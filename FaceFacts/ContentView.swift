//
//  ContentView.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //accessing model context
    @Environment(\.modelContext) var modelContext
    
    //array to keep data for nav stack to use
    @State private var path = [Person]()
    
    //to specify the sorting order for the list
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    
    //var to manage searched text
    @State private var searchText = ""
    
    
    var body: some View {
        //??
        NavigationStack(path: $path) {
            PeopleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("FaceFacts")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person)
                }
                .toolbar {
                    //dropdown menu for sorting
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        //list in the dropdown specified below
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Person.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }
                    
                    Button("Add person", systemImage: "plus", action: addPerson)
                }
                //to have searchbar abv list
                .searchable(text: $searchText)
        }
    }
    
    func addPerson() {
        //creating a blank person obj
        let person = Person(name: "", emailAddress: "", details: "")
        //adding abv created person obj to the modelcontext
        modelContext.insert(person)
        //adding this to path
        path.append(person)
    }
    
    
}

#Preview {
    ContentView()
}
