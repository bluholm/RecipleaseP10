//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-08.
//

import UIKit
import CoreData

final class FavoriteViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    private let cellIdentifier = "cellFavoritesIdentification"
    private var favoritesList: [Favorites] = []
    
    // MARK: - Life Cycle Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    // MARK: - Privates Methods
    func loadData() {
        if let favorites = Favorites.fetchFavorites(context: AppDelegate.context) {
            favoritesList = favorites
        }
        tableView.reloadData()
    }
}

// MARK: - Extensions UITableViewDelegate UITableViewController
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomRecipeCell else {
           return UITableViewCell()
        }
        let favori = favoritesList[indexPath.row]
        let title = favori.title ?? ""
        let fileName = favori.fileName ?? ""
        let ingredients = favori.ingredients ?? ""
        let time = favori.time
        let yield = favori.yield
        let imageURL = ""
        cell.configure(fileName: fileName, imageURL: imageURL, title: title, subtitle: ingredients, yield: String(yield), time: String(time))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "resume") as? DetailViewController {
            vc.favori = favoritesList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let favori = favoritesList[indexPath.row].title {
                DocumentsDirectoryRepository().deleteFiles(favoritesList[indexPath.row].fileName)
                Favorites.deleteFavorites(element: favori, context: AppDelegate.context)
                favoritesList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
