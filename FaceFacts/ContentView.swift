//
//  ContentView.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //to load all the Person obj data from swiftdata db
    //this also will automatically update changes done in the app into swiftdata db table 
    @Query var people: [Person]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
