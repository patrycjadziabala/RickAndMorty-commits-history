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
    @StateObject var viewModel: SearchViewModel
    
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
                        Task {
                            do {
                                let results = try await viewModel.searchCharacter(name: text)
                                navigationPath.append(results)
                            } catch {
                                // TODO: - Error handling
                            }
                        }
//                        self.text = ""
                    }) {
                        Text("Go")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    //                .animation(.default)
                }
            } //HStack
            .navigationDestination(for: [Character].self) { characters in
                StaticCharacterListView(characters: characters)
            }
        } //NavigationStack
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: "Search", viewModel: SearchViewModel(apiManager: APIManager()))
    }
}
