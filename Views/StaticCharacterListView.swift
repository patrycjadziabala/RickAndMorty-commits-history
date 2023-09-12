//
//  StaticCharacterListView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct StaticCharacterListView: View {
    
    let characters: [Character]
    
    var body: some View {
        List {
            ForEach(characters, id: \.id) { character in
                CharacterCellView(character: character)
            } //foreach
        } //List
        .navigationDestination(for: Character.self) { character in
            CharacterDetailsView(characterModel: character)
        }
    }
}

struct StaticCharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        StaticCharacterListView(characters: [])
    }
}
