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
    case fetchLocationFetchFailed
    case searchResultsFailed
}

class CharactersListViewModel: ObservableObject {
    
    enum CharactersListMode {
        case allCharacters
        case charactersForLocation
        case charactersForName
    }
    
    private var charactersForLocationAlreadyFetched: Bool = false
    private let apiManager: APIManagerProtocol
    private let listMode: CharactersListMode
    
    @Published var characters: [Character] = []
    
    init(apiManager: APIManagerProtocol, listMode: CharactersListMode) {
        self.apiManager = apiManager
        self.listMode = listMode
    }
    
    @MainActor
    func fetchCharactersForLocationIfNeeded() async throws {
        guard listMode == .charactersForLocation else {
            print("Attempted to fetch characters for location but listMode is different. Won't proceed.")
            return
        }
        guard charactersForLocationAlreadyFetched == false else {
            print("Won't fetch initial data - already fetched")
            return
        }
        print("Will fetch characters for location")

        if let initialData = await apiManager.fetchCharactersForLocation() {
            characters = initialData
            charactersForLocationAlreadyFetched = true
        } else {
            throw CharactersListViewModelError.fetchLocationFetchFailed
        }
    }
    
    @MainActor
    func fetchNextPageIfNeeded() async throws {
        guard listMode == .allCharacters || listMode == .charactersForName else {
            print("Attempted to fetch next page but listMode doesn't allow paging. Won't proceed.")
            return
        }
        if let nextPageCharacters = await apiManager.fetchNextPage() {
            characters.append(contentsOf: nextPageCharacters)
        } else {
            throw CharactersListViewModelError.fetchNextPageFailed
        }
    }
}
