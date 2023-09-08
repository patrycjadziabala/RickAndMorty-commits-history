//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    //    @EnvironmentObject var apiManager: APIManager
    //    var character: Character
    //    @State var episodeCount: Int
    
    var name: String
    var gender: String
    var species: String
    var status: String
    var origin: String
    var type: String
    var location: String
    var image: String
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: image)) { image in
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
                    Text(status)
                } //hstack
                Divider()
                HStack {
                    Text("Origin")
                    Text(origin)
                } //hstack
                Divider()
                HStack {
                    Text("Type")
                    Text(type)
                } //hstack
                Divider()
                HStack {
                    Text("Location")
                    Text(location)
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
        CharacterDetailsView(name: "", gender: "", species: "", status: "", origin: "", type: "", location: "", image: "")
    }
}
