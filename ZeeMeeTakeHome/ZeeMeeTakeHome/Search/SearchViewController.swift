//
//  ViewController.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/22/23.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel

    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Search"
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return view
    }()

    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Search cocktail"
        view.layoutMargins = UIEdgeInsets.zero
        view.searchTextField.borderStyle = .roundedRect
        view.backgroundImage = UIImage()
        return view
    }()

    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 117
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DrinkCell")
        viewModel.configDataSource(tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide

        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.margin),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeArea.trailingAnchor, constant: -Constants.margin),
        ])

        self.view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.smallMargin),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56),
        ])

        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.margin),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktail = viewModel.dataSource?.itemIdentifier(for: indexPath)
        guard let id = cocktail?.id else { return }
        let viewModel = DetailViewModel(id: id, networkManager: viewModel.networkManager)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let viewController = DetailViewController(viewModel: viewModel)
            viewController.delegate = self
            self.navigationController?.present(viewController, animated: true)
        })
    }
}

extension SearchViewController: DetailViewControllerDelegate {
    func viewControllerDidFinish() {
        self.dismiss(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return searchBar.text == "" && text == " " ? false : true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.replacingOccurrences(of: " ", with: "") != "" else {
            self.viewModel.clearSearchResults()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.viewModel.getSearchResults(searchText)
        })
    }

}

