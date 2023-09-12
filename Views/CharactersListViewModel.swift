//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation
import SwiftUI

enum CharactersListViewModelError: Error {
    case fetchNextPageFailed
    case fetchInitialDataFailed
    case searchResultsFailed
}

class CharactersListViewModel: ObservableObject {
    
    private var shouldFetchInitialData: Bool = true
    private let apiManager: APIManagerProtocol
    @Published var characters: [Character] = []
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    @MainActor
    func fetchInitialData() async throws {
        guard shouldFetchInitialData == true else {
            print("Won't fetch initial data - already fetched")
            return
        }
        print("Will fetch initial data")

        if let initialData = await apiManager.fetchInitialData() {
            characters = initialData
            shouldFetchInitialData = false
        } else {
            throw CharactersListViewModelError.fetchInitialDataFailed
        }
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
