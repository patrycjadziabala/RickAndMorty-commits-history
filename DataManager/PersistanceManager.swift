//
//  PersistanceManager.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import Foundation

final class PersistenceManager: ObservableObject {
    
    @Published var persistedData: [Character]
    private let kPersistedData = "kPersistedData"
    
    init() {
        if let dataFromDefaults = UserDefaults.standard.data(forKey: kPersistedData) {
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([Character].self, from: dataFromDefaults)
            persistedData = decodedData ?? []
        } else {
            persistedData = []
        }
    }
    
    func persist(model: Character) {
        guard !isPersisted(model: model) else {
            return
        }
        persistedData.append(model)
        persistToUserDefaults()
    }
    
    func remove(model: Character) {
        persistedData.removeAll { arrayModel in
            arrayModel == model
        }
        persistToUserDefaults()
    }
    
    func isPersisted(model: Character) -> Bool {
        persistedData.contains { persistedModel in
            model == persistedModel
        }
    }
    
    func togglePersisted(model: Character) {
        if isPersisted(model: model) {
            remove(model: model)
        } else {
            persist(model: model)
        }
    }
    
    func persistToUserDefaults() {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(persistedData)
        UserDefaults.standard.set(data, forKey: kPersistedData)
    }
}
