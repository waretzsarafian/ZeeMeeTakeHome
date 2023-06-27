//
//  CocktailContentView.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/25/23.
//

import Foundation
import UIKit

class CocktailContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.configure(configuration: configuration)
        }
    }

    var drinkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.iconDimension.width / 2
        view.layer.masksToBounds = true
        return view
    }()

    var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return view
    }()

    var categoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .black.withAlphaComponent(0.40)
        return view
    }()

    var instructionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 2
        return view
    }()

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupUI()
        configure(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let safeArea = self.safeAreaLayoutGuide

        self.addSubview(drinkImageView)
        NSLayoutConstraint.activate([
            drinkImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.margin),
            drinkImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.margin),
            drinkImageView.heightAnchor.constraint(equalToConstant: Constants.iconDimension.height),
            drinkImageView.widthAnchor.constraint(equalToConstant: Constants.iconDimension.width),
        ])

        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: drinkImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: Constants.smallMargin),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.mediumMargin),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.mediumMargin)
        ])

        self.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: Constants.mediumMargin)
        ])

        self.addSubview(instructionLabel)
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            instructionLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -19)
        ])

    }

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CocktailConfiguration else { return }
        self.drinkImageView.load(urlString: configuration.thumbnail)
        self.nameLabel.text = configuration.name
        self.categoryLabel.text = configuration.category
        self.instructionLabel.text = configuration.instructions
    }
}
