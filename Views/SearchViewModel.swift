//
//  SearchViewModel.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

final class SearchViewModel: ObservableObject {
    private let apiManager: APIManagerProtocol
    @Published var character: Character?
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func searchCharacter(name: String) {
        
    }
}
