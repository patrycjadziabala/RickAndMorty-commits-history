//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    let characterModel: Character
    @EnvironmentObject var persistanceManager: PersistenceManager
    
    var body: some View {
        ScrollView {
            VStack {
                getPartialView(for: characterModel)
              getPartialView2(for: characterModel)
            } //vstack
        }
    }
    
    @ViewBuilder
    func getPartialView(for character: Character) -> some View {
        AsyncImage(url: URL(string: characterModel.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        } //image
        HStack {
            Text("Name")
            Text(characterModel.name)
            Button {
                persistanceManager.togglePersisted(model: character)
            } label: {
                Image(systemName: persistanceManager.isPersisted(model: character) ? "star.fill" : "star")
            }

        } //hstack
        Divider()
        HStack {
            Text("Gender")
            Text(characterModel.gender)
        } //hstack
        Divider()
        HStack {
            Text("Species")
            Text(characterModel.species)
        } //hstack
        Divider()
        HStack {
            Text("Status")
            Text(characterModel.status)
        } //hstack
        Divider()
    }
    
    @ViewBuilder
    func getPartialView2(for character: Character) -> some View {
        HStack {
            Text("Origin")
            Text(characterModel.origin.name)
        } //hstack
        Divider()
        if let type = characterModel.type {
            HStack {
                Text("Type")
                Text(type)
            } //hstack
            Divider()
        }
        HStack {
            Text("Location")
            Text(characterModel.location.name)
        } //hstack
        Divider()
        //            HStack {
        //                Text("Number of episodes")
        //                Text(episodeCount, format: .number)
        //            } //hstack
        //            Divider()
    }
}


struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CharacterDetailsView(characterModel: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), location: Location(name: "") , image: "", episode: []))
    }
}
