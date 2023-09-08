//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Patka on 07/09/2023.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            
            CharactersListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
