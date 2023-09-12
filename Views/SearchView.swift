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
            VStack {
                Image(Constants.Images.titleImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                TextField(Constants.Titles.search2, text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                        self.text = ""
                    }
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        navigationPath.append(self.text)
                        self.text = ""
                    }) {
                        Text(Constants.Titles.go)
                            .fontWeight(.heavy)
                            .font(.system(size: 25))
                            .foregroundColor(Color(Constants.Colors.customBlue))
                            .shadow(radius: 3)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            } //vstack
            .navigationDestination(for: String.self) { string in
                getListViewForNameSearch(string: string)
            }
            .navigationDestination(for: Character.self) { character in
                CharacterDetailsView(characterModel: character)
            }
            .navigationDestination(for: Origin.self) { origin in
                getCharactersListForLocation(location: origin)
            }
        } //NavigationStack
    }
    
    func getCharactersListForLocation(location: Origin) -> CharactersListView {
        print("attempt to get character list for location")
        let apiManager = APIManager()
        apiManager.setLocationURLString(urlString: location.url)
        let viewModel = CharactersListViewModel(apiManager: apiManager, listMode: .charactersForLocation)
        return CharactersListView(viewModel: viewModel)
    }
    
    func getListViewForNameSearch(string: String) -> CharactersListView {
        let apiManager = APIManager()
        apiManager.configurePaginationForNameSearch(name: string)
        let viewModel = CharactersListViewModel(apiManager: apiManager, listMode: .charactersForName)
        return CharactersListView(viewModel: viewModel)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: "Search")
    }
}
