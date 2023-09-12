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
        StaticCharacterListView(characters: persistanceManager.persistedData)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
