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
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        Task {
            do {
                try await viewModel.fetchCharactersForLocationIfNeeded()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(viewModel.characters, id: \.id) { character in
                CharacterCellView(character: character)
            } //foreach
            ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    Task {
                        do {
                            try await viewModel.fetchNextPageIfNeeded()
                            
                            // TODO: - Error handling
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        } //List
        .onAppear {
            
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager(), listMode: .allCharacters))
    }
}
