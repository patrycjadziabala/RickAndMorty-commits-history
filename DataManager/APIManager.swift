//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation
import SwiftUI

protocol APIManagerProtocol {
    func fetchNextPage() async -> [Character]?
    func configureForNameSearch(name: String)
}

final class APIManager: ObservableObject, APIManagerProtocol {
    
    private var nextPageURLString: String = "https://rickandmortyapi.com/api/character"
    
    func fetchNextPage() async -> [Character]? {
        guard let url = URL(string: nextPageURLString) else {
            print("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
            nextPageURLString = decodedResponse.info.next
            return decodedResponse.results
        } catch {
            print("Invalid data, error: \(error)")
            return nil
        }
    }
    
    func configureForNameSearch(name: String) {
        nextPageURLString = "https://rickandmortyapi.com/api/character/?name=\(name)"
    }
}
