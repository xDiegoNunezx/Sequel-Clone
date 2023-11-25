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
    var body: some Scene {
        WindowGroup {
            MoviesView()
                //.environmentObject(MovieLists())
                .modelContainer(for: [Movie.self])
        }
    }
}
