//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation
import SwiftUI

protocol APIManagerProtocol {
    func fetchNextPage() async
}

final class APIManager: ObservableObject, APIManagerProtocol {
    
    @Published var characters: [Character] = []
    private var nextPageURLString: String = "https://rickandmortyapi.com/api/character"
     
    init() {
        Task {
            await fetchNextPage()
        }
    }
    
    @MainActor
    func fetchNextPage() async {
        guard let url = URL(string: nextPageURLString) else {
            print("Invalid URL")
            
            //TODO: - Add error handling
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
            nextPageURLString = decodedResponse.info.next
            characters.append(contentsOf: decodedResponse.results)
        } catch {
            print("Invalid data, error: \(error)")
        }
    }
}
