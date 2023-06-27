//
//  SearchResponse.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation

struct SearchResponse: Codable {
    var drinks: [Cocktail]
}

struct DetailResponse: Codable {
    var drinks: [CocktailDetail]
}
