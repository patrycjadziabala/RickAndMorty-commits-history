//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    @State private var characters = [Character]()
    
    var body: some View {
        List(characters, id: \.id) { character in
          
            HStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)

                VStack (alignment: .leading) {
                    HStack {
                        Text(character.name)
                    }
                    HStack {
                        HStack {
                            Text("Status:")
                            Text(character.status)
                        }
                        Spacer()
                        HStack {
                            Text("Species:")
                            Text(character.species)
                        }
                    }
                }
            }
        }
        .task {
            await fetchData()
        }
    }
    
    // Move to API Manager
    
    func fetchData() async {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Results.self, from: data) {
                characters = decodedResponse.results
            }
        } catch {
            print("Invalid data, error: \(error)")
        }
    }
    
  
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
