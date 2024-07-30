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
    
    //to load all the Person obj data from swiftdata db
    //this also will automatically update changes done in the app into swiftdata db table
    @Query var people: [Person]
    
    var body: some View {
        //??
        NavigationStack(path: $path) {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text("\(person.name)")
                    }
                }
                .onDelete(perform: deletePeople) //swipe right to delete a record, this automatically pass
            }
            .navigationTitle("FaceFacts")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person)
            }
            .toolbar {
                Button("Add person", systemImage: "plus", action: addPerson)
            }
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
    
    //fn to delete person
    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            print("offset: \(offset)")
            let person = people[offset]
            //deleting from modelcontext
            modelContext.delete(person)
        }
    }
}

#Preview {
    ContentView()
}
