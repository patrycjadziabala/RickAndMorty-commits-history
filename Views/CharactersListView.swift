//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject var viewModel: CharactersListViewModel
    @EnvironmentObject var persistanceManager: PersistenceManager
    
    var body: some View {
        
        List {
            ForEach(viewModel.characters, id: \.id) { character in
                CharacterCellView(character: character)
            } //foreach
            Text("Test")
                .onAppear {
                    Task {
                        do {
                            try await viewModel.fetchNextPage()
                            
                            // TODO: - Error handling
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        } //List
        .navigationDestination(for: Character.self) { character in
            CharacterDetailsView(characterModel: character)
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
    }
}
