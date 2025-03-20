//
//  NewsAssignmentApp.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 20/03/2025.
//

import SwiftUI

@main
struct NewsAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
