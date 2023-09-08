//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

final class CharactersListViewModel: ObservableObject {
    
    enum CharactersListViewModelError: Error {
        case fetchNextPageFailed
    }
    
    let apiManager: APIManagerProtocol
    @Published var characters: [Character] = []
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    @MainActor
    func fetchNextPage() async throws {
        if let nextPageCharacters = await apiManager.fetchNextPage() {
            characters.append(contentsOf: nextPageCharacters)
        } else {
            throw CharactersListViewModelError.fetchNextPageFailed
        }
    }
}
