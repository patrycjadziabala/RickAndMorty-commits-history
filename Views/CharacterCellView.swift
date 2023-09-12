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
                ZStack {
                    Circle()
                        .fill(Color(Constants.Colors.customLightBrown))
                        .opacity(0.6)
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    } //image
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                } //zstack
                HStack {
                    VStack (alignment: .leading) {
                        Text(character.name)
                            .font(Font.headline.weight(.bold))
                        HStack {
                            Text(Constants.Titles.status2)
                            Text(character.status)
                        } //hstack
                        .font(Font.headline.weight(.light))
                        HStack {
                            Text(Constants.Titles.species2)
                            Text(character.species)
                        } //hstack
                        .font(Font.headline.weight(.light))
                    } //vstack
                    .scaledToFit()
                    Spacer()
                    if persistanceManager.isPersisted(model: character) {
                        Image(systemName: Constants.Images.starFill)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.yellow)
                            .shadow(radius: 1)
                    }
                } //hstack
            } //hstack
        } //NavigationLink
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCellView(character: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "") , image: "", episode: []))
    }
}
