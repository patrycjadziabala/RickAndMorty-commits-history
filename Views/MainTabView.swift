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
            }
            .navigationDestination(for: Character.self) { character in
                CharacterDetailsView(characterModel: character)
            }
            .tabItem {
                Label(Constants.Titles.home, systemImage: Constants.Images.homeIcon)
            }
            NavigationStack {
                FavouritesView()
            }
            .tabItem {
                Label(Constants.Titles.favourites, systemImage: Constants.Images.star )
            }
            SearchView(text: Constants.Titles.search)
                .tabItem {
                    Label(Constants.Titles.search, systemImage: Constants.Images.magnifyingGlass)
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
