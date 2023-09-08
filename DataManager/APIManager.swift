//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

final class APIManager: ObservableObject {
    
    @Published var characters: [Character] = []
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    @MainActor
    func fetchData() async {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
            characters = decodedResponse.results
        } catch {
            print("Invalid data, error: \(error)")
        }
    }
}
