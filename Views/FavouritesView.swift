//
//  FavouritesView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var persistanceManager: PersistenceManager
    
    var body: some View {
        List {
            ForEach(persistanceManager.persistedData, id: \.id) { character in
                CharacterCellView(character: character)
            } //foreach
        } //List
        .navigationDestination(for: Character.self) { character in
            CharacterDetailsView(characterModel: character)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
