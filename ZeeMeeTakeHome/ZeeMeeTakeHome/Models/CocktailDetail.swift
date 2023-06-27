//
//  CocktailDetail.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation

struct CocktailDetail: Codable {
    var id: String
    var name: String
    var category: String
    var instructions: String
    var thumbnail: String

    var glass: String
    var ingredient1: String
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?

    var measurement1: String?
    var measurement2: String?
    var measurement3: String?
    var measurement4: String?
    var measurement5: String?
    var measurement6: String?
    var measurement7: String?
    var measurement8: String?
    var measurement9: String?
    var measurement10: String?
    var measurement11: String?
    var measurement12: String?
    var measurement13: String?
    var measurement14: String?
    var measurement15: String?

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"

        case glass = "strGlass"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"

        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
    }

    var shareableString: String {
        var text = "\(name)\n\(instructions)\n"
        for (ingredient, measurement) in getIngredients() {
            text += "\(measurement ?? "") \(ingredient ?? "")\n"
        }
        return text
    }

    func getIngredients() -> [(ingredient: String?, measurement: String?)] {
        return [
            (ingredient1, measurement1),
            (ingredient2, measurement2),
            (ingredient3, measurement3),
            (ingredient4, measurement4),
            (ingredient5, measurement5),
            (ingredient6, measurement6),
            (ingredient7, measurement7),
            (ingredient8, measurement8),
            (ingredient9, measurement9),
            (ingredient10, measurement10),
            (ingredient11, measurement11),
            (ingredient12, measurement12),
            (ingredient13, measurement13),
            (ingredient14, measurement14),
            (ingredient15, measurement15),
        ].filter({ $0.ingredient != nil })
    }
}
