//
//  NetworkManager.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation
import UIKit

struct NetworkManager {
    private let searchAPI: String = "https://www.thecocktaildb.com/api/json/v1/1/search.php"
    private let detailAPI: String = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php"

    func getSearchResults(_ searchText: String) async throws -> [Cocktail] {
        guard var searchURL = URL(string: searchAPI) else { return [] }
        searchURL.append(queryItems: [URLQueryItem(name: "s", value: searchText)])

        let (data, _) = try await URLSession.shared.data(from: searchURL)
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.drinks
    }

    func getDetailResults(_ cocktailId: String) async throws -> [CocktailDetail] {
        guard var detailURL = URL(string: detailAPI) else { return [] }
        detailURL.append(queryItems: [URLQueryItem(name: "i", value: cocktailId)])

        let (data, _) = try await URLSession.shared.data(from: detailURL)
        let decoded = try JSONDecoder().decode(DetailResponse.self, from: data)
        return decoded.drinks
    }
}
