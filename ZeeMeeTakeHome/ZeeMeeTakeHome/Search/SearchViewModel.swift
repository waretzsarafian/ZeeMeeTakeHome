//
//  SearchViewModel.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/23/23.
//

import Foundation
import UIKit

class SearchViewModel {
    typealias DataSource = UITableViewDiffableDataSource<Int, Cocktail>
    var dataSource: DataSource?

    var networkManager: NetworkManager

    init(_ networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getSearchResults(_ searchText: String) {
        Task.init {
            let searchData = try await networkManager.getSearchResults(searchText)
            updateSnapshot(searchData)
        }
    }

    func clearSearchResults() {
        updateSnapshot([])
    }

    func updateSnapshot(_ items: [Cocktail], animated: Bool = false) {
        guard let dataSource = dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Cocktail>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)

        DispatchQueue.main.async {
            dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }

    func configDataSource(_ tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource<Int, Cocktail>(tableView: tableView) { tableView, indexPath, cocktail in
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath)
            let contentConfiguration = CocktailConfiguration(id: cocktail.id,
                                                             name: cocktail.name,
                                                             category: cocktail.category,
                                                             instructions: cocktail.instructions,
                                                             thumbnail: cocktail.thumbnail)
            cell.contentConfiguration = contentConfiguration
            return cell
        }
        updateSnapshot([])
    }
}
