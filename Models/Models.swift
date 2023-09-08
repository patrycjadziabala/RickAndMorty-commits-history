//
//  Models.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

struct Results: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
}

struct Origin: Codable {
    let name: String
}

struct Location: Codable {
    let name: String
}
