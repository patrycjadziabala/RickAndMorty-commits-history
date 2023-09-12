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
        ZStack {
            AsyncImage(url: URL(string: characterModel.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            } //image
            .clipShape(Circle())
            .frame(width: 370)
            Button {
                persistanceManager.togglePersisted(model: character)
            } label: {
                Image(systemName: persistanceManager.isPersisted(model: character) ? Constants.Images.starFill : Constants.Images.star)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.yellow)
            } //button
            .offset(x: 125, y: -130)
        } //zstack
        .padding()
        HStack {
            VStack {
                Text(Constants.Titles.name)
                Divider()
                Text(Constants.Titles.gender)
                Divider()
                Text(Constants.Titles.species)
                Divider()
                Text(Constants.Titles.status)
                Divider()
            } //vstack
            .font(Font.headline.weight(.bold))
            .padding()
            Divider()
            VStack {
                Text(characterModel.name)
                Divider()
                Text(characterModel.gender)
                Divider()
                Text(characterModel.species)
                Divider()
                Text(characterModel.status)
                Divider()
            } //vstack
            .font(Font.headline.weight(.light))
            .padding()
        } //hstack
    }
    
    @ViewBuilder
    func getPartialView2(for character: Character) -> some View {
        HStack {
            VStack {
                Text(Constants.Titles.origin)
                Divider()
                if ((character.type?.isEmpty) != nil) {
                    Text(Constants.Titles.type).hidden()
                } else {
                    Text(Constants.Titles.type)
                    Divider()
                }
                Text(Constants.Titles.location)
            } //vstack
            .font(Font.headline.weight(.bold))
            Divider()
            VStack {
                NavigationLink(value: characterModel.origin) {
                    Text(characterModel.origin.name)
                }
                Divider()
                if ((character.type?.isEmpty) != nil) {
                    Text(character.type ?? "").hidden()
                } else {
                    Text(character.type ?? "")
                    Divider()
                }
                Text(characterModel.location.name)
            } //vstack
            .font(Font.headline.weight(.light))
        } //hstack
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(characterModel: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "") , image: "", episode: []))
    }
}
