//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct SearchView: View {
    @State var text: String
    @State private var isEditing = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            HStack {
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        
                    }) {
                        Text("Go")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    //                .animation(.default)
                }
            } //HStack
            .navigationDestination(for: Character.self) { character in
                CharacterDetailsView(characterModel: character)
            }
        } //NavigationStack
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: "Search")
    }
}
