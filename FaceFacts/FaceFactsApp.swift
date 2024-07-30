//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Mayur Vaity on 30/07/24.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)  //to create Person data table in swift data (1st time only) and to access data stored in this table (1st time onwards)
    }
}
