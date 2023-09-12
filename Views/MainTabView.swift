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
                CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager(),
                                                                      listMode: .allCharacters))
                    .navigationDestination(for: Character.self) { character in
                        CharacterDetailsView(characterModel: character)
                    }
                    .navigationDestination(for: Origin.self) { origin in
                        getCharactersListForLocation(location: origin)
                    }
            }
            .tabItem {
                Label(Constants.Titles.home, systemImage: Constants.Images.homeIcon)
            }
            NavigationStack {
                FavouritesView()
                    .navigationDestination(for: Character.self) { character in
                        CharacterDetailsView(characterModel: character)
                    }
                    .navigationDestination(for: Origin.self) { origin in
                        getCharactersListForLocation(location: origin)
                    }
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
    
    func getCharactersListForLocation(location: Origin) -> CharactersListView {
        print("attempt to get character list for location")
        let apiManager = APIManager()
        apiManager.setLocationURLString(urlString: location.url)
        let viewModel = CharactersListViewModel(apiManager: apiManager,
                                                listMode: .charactersForLocation)
        return CharactersListView(viewModel: viewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
