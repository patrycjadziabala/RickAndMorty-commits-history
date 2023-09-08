//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var persistanceManager: PersistenceManager = PersistenceManager()
    
    var body: some View {
        TabView {
            NavigationStack {
                CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
            }
            NavigationStack {
                FavouritesView()
                    .tabItem {
                        Label("Fav", systemImage: "house.fill")
                    }
            }
        } //tabview
        .environmentObject(persistanceManager)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
