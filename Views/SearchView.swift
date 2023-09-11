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
                TextField(Constants.Titles.search2, text: $text)
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
                        navigationPath.append(self.text)
                        self.text = ""
                    }) {
                        Text(Constants.Titles.go)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    //                .animation(.default)
                }
            } //HStack
            .navigationDestination(for: String.self) { string in
                getListViewForNameSearch(string: string)
            }
        } //NavigationStack
    }
    
    func getListViewForNameSearch(string: String) -> CharactersListView {
        let apiManager = APIManager()
        apiManager.configurePaginationForNameSearch(name: string)
        let viewModel = CharactersListViewModel(apiManager: apiManager)
        return CharactersListView(viewModel: viewModel)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: "Search")
    }
}
