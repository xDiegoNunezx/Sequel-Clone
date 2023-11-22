//
//  SequelCloneApp.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct SequelCloneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MovieData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MoviesView()
                .environmentObject(MovieLists())
                .modelContainer(sharedModelContainer)
        }
    }
}
