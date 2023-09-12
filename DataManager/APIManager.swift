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
    func fetchCharactersForLocation() async -> [Character]?
    func configurePaginationForNameSearch(name: String)
    func setLocationURLString(urlString: String)
}

final class APIManager: ObservableObject, APIManagerProtocol {
    
    private var nextPageURLString: String = "https://rickandmortyapi.com/api/character"
    private var locationURLString: String?
    
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
            print("Invalid data, error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchCharactersForLocation() async -> [Character]? {
        guard let locationURLString = locationURLString else {
            print("Could not fetch characters for location: location URL string not found.")
            return nil
        }
        guard let residentUrls = await fetchResidentsUrlsForLocation(locationURL: locationURLString) else {
            return nil
        }
        let idsArray = residentUrls.compactMap({ residentUrl in
            return getCharacterId(fromCharacterUrl: residentUrl)
        })
        let charactersForLocation = await fetchCharacters(forIdsArray: idsArray)
        return charactersForLocation
    }
    
    func setLocationURLString(urlString: String) {
        locationURLString = urlString
    }
    
    func configurePaginationForNameSearch(name: String) {
        nextPageURLString = "https://rickandmortyapi.com/api/character/?name=\(name)"
    }
    
    private func fetchResidentsUrlsForLocation(locationURL: String) async -> [String]? {
        guard let url = URL(string: locationURL) else {
            print("Could not fetch characters for location: location URL string invalid")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(LocationModel.self, from: data)
            return decodedResponse.residents
        } catch {
            print("Character links for location fetch failed, \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getCharacterId(fromCharacterUrl url: String) -> String? {
        url.components(separatedBy: "/").last
    }
    
    private func fetchCharacters(forIdsArray array: [String]) async -> [Character]? {
        let baseUrlString = "https://rickandmortyapi.com/api/character/"
        let idsString = array.joined(separator: ",")
        let urlString = baseUrlString + idsString
        guard let url = URL(string: urlString) else {
            print("Invalid character list for location URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([Character].self, from: data)
            return decodedResponse
        } catch {
            print("Characters for location fetch failed, \(error.localizedDescription)")
            return nil
        }
    }
}
