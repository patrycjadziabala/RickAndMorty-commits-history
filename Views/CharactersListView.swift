//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    
    @EnvironmentObject var apiManager: APIManager
    @State private var characterPresented: Character?
    
    var body: some View {
        List(apiManager.characters, id: \.id) { character in
          
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
            .onTapGesture {
                characterPresented = character
            }
        } //List
        .sheet(item: $characterPresented) { character in
            CharacterDetailsView(character: character)
        }
//        .task {
//            await apiManager.fetchData()
//        }
    } 
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
