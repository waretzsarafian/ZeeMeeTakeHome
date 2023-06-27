//
//  CocktailConfiguration.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/25/23.
//

import Foundation
import UIKit

struct CocktailConfiguration: UIContentConfiguration {

    var id: String
    var name: String
    var category: String
    var instructions: String
    var thumbnail: String
    
    func makeContentView() -> UIView & UIContentView {
        return CocktailContentView(self)
    }

    func updated(for state: UIConfigurationState) -> CocktailConfiguration {
        return self
    }


}
