//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    @EnvironmentObject var apiManager: APIManager
    var character: Character
//    @State var episodeCount: Int
    
    var body: some View {
        VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                } //image
            
            HStack {
                Text("Name")
                Text(character.name)
            } //hstack
            Divider()
            HStack {
                Text("Gender")
                Text(character.gender)
            } //hstack
            Divider()
            HStack {
                Text("Species")
                Text(character.species)
            } //hstack
            Divider()
            HStack {
                Text("Status")
                Text(character.status)
            } //hstack
            Divider()
            HStack {
                Text("Origin")
                Text(character.origin.name)
            } //hstack
            Divider()
            HStack {
                Text("Type")
                Text(character.type ?? "Type unavailable")
                } //hstack
            Divider()
            HStack {
                Text("Location")
                Text(character.location.name)
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


struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let apiManager = APIManager()
        CharacterDetailsView(character: apiManager.characters[0])
    }
}
