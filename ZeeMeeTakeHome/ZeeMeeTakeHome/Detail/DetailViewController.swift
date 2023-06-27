//
//  DetailViewController.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate {
    func viewControllerDidFinish()
}

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel
    var delegate: DetailViewControllerDelegate?

    let dismissIcon: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "downIcon"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .black
        return view
    }()

    let shareDrinkIcon: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "shareIcon"), for: .normal)
        view.tintColor = .black
        return view
    }()

    var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return view
    }()

    var cocktailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    var cocktailImageLabel: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.cornerStyle = .medium
        config.background.backgroundColor = UIColor(red: 21/255, green: 198/255, blue: 91/255, alpha: 1)
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)

        let view = UIButton(configuration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        view.setTitleColor(.white, for: .normal)
        return view
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    var instructionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        return view
    }()

    let glassLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let shareButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.cornerStyle = .medium
        config.title = "Share"
        config.image = UIImage(named: "shareIcon")?.withTintColor(.white)
        config.background.backgroundColor = .blue
        config.imagePadding = 8.0

        let view = UIButton(configuration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        return view
    }()

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
    }

    private func setupNavBar() {
        let safeArea = self.view.safeAreaLayoutGuide

        self.view.addSubview(dismissIcon)
        dismissIcon.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.dismissIcon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.mediumMargin),
            self.dismissIcon.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.margin),
            self.dismissIcon.heightAnchor.constraint(equalToConstant: Constants.mediumMargin),
            self.dismissIcon.widthAnchor.constraint(equalTo: self.dismissIcon.heightAnchor)
        ])

        self.view.addSubview(shareDrinkIcon)
        shareDrinkIcon.addTarget(self, action: #selector(shareDrink), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.shareDrinkIcon.topAnchor.constraint(equalTo: dismissIcon.topAnchor),
            self.shareDrinkIcon.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.margin),
            self.shareDrinkIcon.heightAnchor.constraint(equalToConstant: Constants.mediumMargin),
            self.shareDrinkIcon.widthAnchor.constraint(equalTo: self.shareDrinkIcon.heightAnchor)
        ])
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        let safeArea = self.view.safeAreaLayoutGuide
        guard let drink = viewModel.cocktail.first else { return }

        self.view.addSubview(titleLabel)
        titleLabel.text = drink.name
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: dismissIcon.bottomAnchor, constant: Constants.margin),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.margin),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constants.margin),
        ])

        self.view.addSubview(cocktailImageView)
        cocktailImageView.load(urlString: drink.thumbnail)
        NSLayoutConstraint.activate([
            cocktailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.margin),
            cocktailImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            cocktailImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            cocktailImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])

        self.view.addSubview(cocktailImageLabel)
        cocktailImageLabel.setTitle(drink.category, for: .normal)
        cocktailImageLabel.sizeToFit()
        NSLayoutConstraint.activate([
            cocktailImageLabel.leadingAnchor.constraint(equalTo: self.cocktailImageView.leadingAnchor, constant: Constants.mediumMargin),
            cocktailImageLabel.centerYAnchor.constraint(equalTo: self.cocktailImageView.centerYAnchor),
        ])

        self.view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(shareDrink), for: .touchUpInside)
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            shareButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.mediumMargin),
            shareButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.mediumMargin),
            shareButton.heightAnchor.constraint(equalToConstant: 64),
        ])

        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: cocktailImageLabel.bottomAnchor, constant: Constants.mediumMargin),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -Constants.mediumMargin)
        ])

        instructionLabel.text = drink.instructions
        let instructView = instructionLabel.titledView("Instructions")
        self.contentView.addSubview(instructView)
        NSLayoutConstraint.activate([
            instructView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.mediumMargin),
            instructView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.mediumMargin),
            instructView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.mediumMargin)
        ])

        let ingredientView = createIngredientView(drink)
        self.contentView.addSubview(ingredientView)
        NSLayoutConstraint.activate([
            ingredientView.topAnchor.constraint(equalTo: instructView.bottomAnchor, constant: Constants.mediumMargin),
            ingredientView.leadingAnchor.constraint(equalTo: instructView.leadingAnchor),
            ingredientView.trailingAnchor.constraint(equalTo: instructView.trailingAnchor),
        ])

        glassLabel.text = drink.glass
        let glassView = glassLabel.titledView("Glass Needed")
        self.contentView.addSubview(glassView)
        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: ingredientView.bottomAnchor, constant: Constants.mediumMargin),
            glassView.leadingAnchor.constraint(equalTo: instructView.leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: instructView.trailingAnchor),
            glassView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)
        ])

        self.view.bringSubviewToFront(shareButton)
    }

    @objc private func dismissVC() {
        delegate?.viewControllerDidFinish()
    }

    @objc private func shareDrink(_ sender: UIButton) {
        guard let drink = viewModel.cocktail.first else { return }
        let ac = UIActivityViewController(activityItems: [drink.shareableString], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = sender
        present(ac, animated: true)

    }

    private func createIngredientView(_ cocktail: CocktailDetail) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for (ingredient, measure) in cocktail.getIngredients() {
            guard let ingredient = ingredient else { break }
            stackView.addArrangedSubview(UIView.createIngredientRow(ingredient, measure: measure))
        }

        return stackView.titledView("\(stackView.subviews.count) Ingredients")
    }

}
