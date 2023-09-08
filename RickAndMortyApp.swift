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

    @StateObject var apiManager = APIManager()
    
    var body: some Scene {
        WindowGroup {            
            MainTabView()
                .environmentObject(apiManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
