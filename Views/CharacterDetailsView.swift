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
            Text(Constants.Titles.name)
            Text(characterModel.name)
            Button {
                persistanceManager.togglePersisted(model: character)
            } label: {
                Image(systemName: persistanceManager.isPersisted(model: character) ? Constants.Images.starFill : Constants.Images.star)
            }
        } //hstack
        Divider()
        HStack {
            Text(Constants.Titles.gender)
            Text(characterModel.gender)
        } //hstack
        Divider()
        HStack {
            Text(Constants.Titles.species)
            Text(characterModel.species)
        } //hstack
        Divider()
        HStack {
            Text(Constants.Titles.status)
            Text(characterModel.status)
        } //hstack
        Divider()
    }
    
    @ViewBuilder
    func getPartialView2(for character: Character) -> some View {
        HStack {
            NavigationLink(value: characterModel.origin) {
                Text(Constants.Titles.origin)
                Text(characterModel.origin.name)
            }
        } //hstack
        Divider()
        if let type = characterModel.type {
            HStack {
                Text(Constants.Titles.type)
                Text(type)
            } //hstack
            Divider()
        }
            HStack {
                Text(Constants.Titles.location)
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
        CharacterDetailsView(characterModel: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "") , image: "", episode: []))
    }
}
