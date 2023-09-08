//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct MainTabView: View {
    
    
    var body: some View {
        TabView {
            CharactersListView(viewModel: CharactersListViewModel())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            FavouritesView()
                .tabItem {
                    Label("Fav", systemImage: "house.fill")
                }
        } //tabview
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
