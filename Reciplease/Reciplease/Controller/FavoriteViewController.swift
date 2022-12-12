//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-08.
//

import UIKit
import CoreData

final class FavoriteViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    private let cellIdentifier = "cellFavoritesIdentification"
    private let repository = FavoritesRepository()
    private var favorites: [NSManagedObject] = []
    
    //MARK: - Life Cycle Method
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    //MARK: - Privates Methods
    
    func getData() {
        repository.getData { data in
            self.favorites = data
        }
        tableView.reloadData()
    }
}

//MARK: - Extensions UITableViewDelegate UITableViewController

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomRecipeCell else {
           return UITableViewCell()
        }
        let favori = favorites[indexPath.row]
        let title = favori.value(forKey: ConstantKey.title) as? String ?? ""
        let fileName = favori.value(forKey: ConstantKey.fileName) as? String ?? ""
        let ingredients = favori.value(forKey: ConstantKey.ingredients) as? String ?? ""
        let time = favori.value(forKey: ConstantKey.time) as? Int ?? 0
        let yield = favori.value(forKey: ConstantKey.yield) as? Int ?? 0
        let imageURL = ""
        cell.configure(fileName: fileName, imageURL: imageURL, title: title, subtitle: ingredients, yield: String(yield), time: String(time))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "resume") as? DetailViewController {
            vc.recipeNS = favorites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favori = favorites[indexPath.row]
            repository.deleteData(data: favori)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
