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
                            try await viewModel.fetchNextPage()
                            
                            // TODO: - Error handling
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        } //List
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchInitialData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager(shouldPerformPagination: false)))
    }
}
