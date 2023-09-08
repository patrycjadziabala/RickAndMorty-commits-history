//
//  SearchViewModel.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

final class SearchViewModel: ObservableObject {
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    @MainActor
    func searchCharacter(name: String) async throws -> [Character] {
        if let characterResults = await apiManager.searchCharacter(name: name) {
            return characterResults
        } else {
            throw CharactersListViewModelError.searchResultsFailed
        }
    }
}
