//
//  Cocktail.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation

struct Cocktail: Codable, Hashable {
    var id: String
    var name: String
    var category: String
    var instructions: String
    var thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
    }

    static func == (lhs: Cocktail, rhs: Cocktail) -> Bool {
        return lhs.id == rhs.id
    }
}
