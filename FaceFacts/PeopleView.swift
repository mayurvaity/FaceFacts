//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 31/07/24.
//
import SwiftData
import SwiftUI

struct PeopleView: View {
    //accessing model context
    @Environment(\.modelContext) var modelContext
    
    //to load all the Person obj data from swiftdata db
    //this also will automatically update changes done in the app into swiftdata db table
    @Query var people: [Person]
    
    
    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text("\(person.name)")
                }
            }
            .onDelete(perform: deletePeople) //swipe right to delete a record, this automatically pass
        }
    }
    
    //to search for searchbar
    //everytime user searches peopleview gets recreated 
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        //querying the "people" var based on our search string
        //_people - (underscore var name) it says change the query not the array underneath it
        _people = Query(filter: #Predicate { person in
            //if search string is empty then show all records
            if searchString.isEmpty {
                true
            } else {
                //if there is any search string, search accordingly (to search name, email address as well as details )
                person.name.localizedStandardContains(searchString)
                || person.emailAddress.localizedStandardContains(searchString)
                || person.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
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
    PeopleView()
}
