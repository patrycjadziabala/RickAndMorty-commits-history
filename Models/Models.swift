//
//  Models.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

struct Results: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String
}

struct Character: Codable, Identifiable, Hashable, Equatable {
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

struct Origin: Codable, Equatable, Hashable {
    let name: String
    let url: String
}

struct Location: Codable, Equatable, Hashable {
    let name: String
    
}

struct LocationModel: Codable, Hashable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
    let url: String
}

