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
                NavigationLink(value: character) {
                    HStack {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        } //image
                        .frame(width: 50, height: 50)
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Text(character.name)
                                if persistanceManager.isPersisted(model: character) {
                                    Image(systemName: "star.fill")
                                }
                            } //hstack
                            HStack {
                                HStack {
                                    Text("Status:")
                                    Text(character.status)
                                } //hstack
                                HStack {
                                    Text("Species:")
                                    Text(character.species)
                                } //hstack
                            } //hstack
                        } //vstack
                    } //hstack
                } //NavigationLink
                
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
