//
//  DetailViewModel.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation

class DetailViewModel {
    var cocktail: [CocktailDetail] = []
    var ingredients: [String] = []

    private let networkManager: NetworkManager

    init(id: String, networkManager: NetworkManager) {
        self.networkManager = networkManager
        Task.init {
            self.cocktail = try await getData(id)
        }
    }

    deinit {
        cocktail = []
        ingredients = []
    }

    private func getData(_ id: String) async throws -> [CocktailDetail] {
        return try await networkManager.getDetailResults(id)
    }
}
