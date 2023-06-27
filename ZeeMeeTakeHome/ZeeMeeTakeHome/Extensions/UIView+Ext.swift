//
//  UIView+Ext.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation
import UIKit

extension UIView {
    func titledView(_ title: String, isUppercase: Bool = true) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        let titleText = isUppercase ? title.uppercased() : title
        titleLabel.text = titleText
        titleLabel.textColor = .black.withAlphaComponent(0.40)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if isUppercase { titleLabel.text = title.uppercased() }

        view.addSubview(titleLabel)
        view.addSubview(self)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }

    static func createIngredientRow(_ ingredient: String, measure: String?) -> UIView {
        let view = UIView()
        let safeArea = view.safeAreaLayoutGuide
        view.translatesAutoresizingMaskIntoConstraints = false

        let measurementLabel = UILabel()
        measurementLabel.text = measure
        measurementLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false

        let ingredientLabel = UILabel()
        ingredientLabel.text = ingredient
        ingredientLabel.font = UIFont.systemFont(ofSize: 14)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(measurementLabel)
        view.addSubview(ingredientLabel)

        NSLayoutConstraint.activate([
            measurementLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            measurementLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            measurementLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            ingredientLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            ingredientLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            ingredientLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: measurementLabel.trailingAnchor)
        ])

        return view
    }
}
