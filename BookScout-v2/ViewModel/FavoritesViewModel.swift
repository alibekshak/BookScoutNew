//
//  FavoritesViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    private let userDefaultsKey = "FavoriteItems"
    
    static let shared = FavoritesViewModel()

    @Published var favoriteItems: [FavoriteItem] = []

    init() {
            self.favoriteItems = loadFavoriteItems()
        }

    private func saveFavoriteItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(favoriteItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }

    private func loadFavoriteItems() -> [FavoriteItem] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return []
        }
        if let decodedData = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
            return decodedData
        }
        return []
    }

    func addToFavorites(item: FavoriteItem) {
        if !favoriteItems.contains(item) {
            favoriteItems.append(item)
            saveFavoriteItems()
        }
    }
    
    func refreshFavoriteItems() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.favoriteItems = self.loadFavoriteItems()
        }
    }

    func deleteFavoriteItem(at offsets: IndexSet) {
        favoriteItems.remove(atOffsets: offsets)
        saveFavoriteItems()
    }

    func moveFavoriteItem(from source: IndexSet, to destination: Int) {
        favoriteItems.move(fromOffsets: source, toOffset: destination)
        saveFavoriteItems()
    }
}
