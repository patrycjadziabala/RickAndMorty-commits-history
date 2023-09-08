//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    let characterModel: Character
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: characterModel.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                } //image
                
                // TODO: - Rozbic na mniejsze widoki
                
//                HStack {
//                    Text("Name")
//                    Text(name)
//                } //hstack
//                Divider()
//                HStack {
//                    Text("Gender")
//                    Text(gender)
//                } //hstack
//                Divider()
//                HStack {
//                    Text("Species")
//                    Text(species)
//                } //hstack
                Divider()
                HStack {
                    Text("Status")
                    Text(characterModel.status)
                } //hstack
                Divider()
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
            } //vstack
        }
    }
}


struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CharacterDetailsView(characterModel: Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), location: Location(name: "") , image: "", episode: []))
    }
}
