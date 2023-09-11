//
//  ListViewCellView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character
    @EnvironmentObject var persistanceManager: PersistenceManager
    
    var body: some View {
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
                            Image(systemName: Constants.Images.starFill)
                        }
                    } //hstack
                    HStack {
                        HStack {
                            Text(Constants.Titles.status2)
                            Text(character.status)
                        } //hstack
                        HStack {
                            Text(Constants.Titles.species2)
                            Text(character.species)
                        } //hstack
                    } //hstack
                } //vstack
            } //hstack
        } //NavigationLink
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCellView(character: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "") , image: "", episode: []))
    }
}
