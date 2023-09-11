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
                CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager( shouldPerformPagination: true)))
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
            
            NavigationStack {
                SearchView(text: Constants.Titles.search)
                .navigationDestination(for: Character.self) { character in
                    CharacterDetailsView(characterModel: character)
                }
                .navigationDestination(for: Origin.self) { origin in
                    getCharactersListForLocation(location: origin)
                }
            }
            .tabItem {
                Label(Constants.Titles.search, systemImage: Constants.Images.magnifyingGlass)
            }

        } //tabview
        .environmentObject(persistanceManager)
    }
    
    func getCharactersListForLocation(location: Origin) -> CharactersListView {
        print("attempt to get character list for location")
        let apiManager = APIManager(locationURLString: location.url, shouldPerformPagination: false)
        let viewModel = CharactersListViewModel(apiManager: apiManager)
        return CharactersListView(viewModel: viewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
