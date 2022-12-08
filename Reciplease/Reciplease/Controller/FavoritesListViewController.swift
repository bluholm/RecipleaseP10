//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-08.
//

import UIKit

final class FavoritesListViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    private let cellIdentifier = "cellFavoritesIdentification"
    private var favoritesList = [Recipie]()
    private let favoriteRepository = FavoritesRepository()
    
    //MARK: - Life Cycle Method
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    //MARK: - Private
    
    private func loadData() {
        favoritesList.removeAll()
        favoriteRepository.getData { data in
            data.forEach { favorite in
                guard let title = favorite.title else { return }
                let yield = favorite.yield
                let time = favorite.time
                guard let ingredient = favorite.ingredients else { return }
                
                let item = Recipie(title: title, ingredients: [ingredient], time: Int(time), image: "", yield: Int(yield), url: URL(string: "http://google.com")!)
                self.favoritesList.append(item)
            }
        }
        tableView.reloadData()
    }
}

//MARK: - Extensions UITableViewDelegate UITableViewController

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipiesTableViewCell else {
           return UITableViewCell()
        }
        var time: String {
            if favoritesList[indexPath.row].time == 0 {
                return "N/A"
            } else {
                return String(Int(favoritesList[indexPath.row].time))+"m"
            }
        }
        cell.configure(image: favoritesList[indexPath.row].image,
                       title: favoritesList[indexPath.row].title,
                       subtitle: favoritesList[indexPath.row].ingredients[0],
                       note: String(favoritesList[indexPath.row].yield),
                       time: time
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "resume") as? ResumeViewController {
            vc.recipe = favoritesList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //TODO: - complete
    }
    
    
}
