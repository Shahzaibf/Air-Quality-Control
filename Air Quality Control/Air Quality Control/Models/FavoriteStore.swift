//
//  FavoriteStore.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/16/24.
//

import Foundation
import SwiftUI

@Observable
class FavoriteStore {
    @AppStorage("Favories") private var favoritesData: String = ""
    private var cities: Set<City> = []
    private let key = "Favorites"
    
    init() {
        load()
    }
    
    private func load() {
        if let data = favoritesData.data(using: .utf8),
           let decoded = try? JSONDecoder().decode(Set<City>.self, from: data) {
            cities = decoded
        } else {
            cities = []
        }
    }
    
    func add(_ city: City) {
        cities.insert(city)
        save()
    }
    
    
    func remove(_ city: City) {
        cities.remove(city)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(cities) {
            favoritesData = String(decoding: encoded, as: Unicode.UTF8.self)
        }
    }
    
    func contains(_ city: City) -> Bool {
        return cities.contains(city)
    }
    
    func allFavorites() -> [City] {
        return Array(cities).sorted(by: { $0.name < $1.name })
    }
    
}
