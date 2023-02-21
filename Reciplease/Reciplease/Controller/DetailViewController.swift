//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-06.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var favoriteNavigationBarIcon: UIBarButtonItem!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var yieldLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    var favori = Favorites()
    var recipe = Recipie(title: "", ingredients: [""], time: 0, fileName: "", imageurl: "", yield: 0, url: "")
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.applyGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if recipe.title == "" {
           createRecipeWithFavori()
        }
        self.loadRecipe()
        self.updateFavoriteIcon()
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonDidTapped(_ sender: Any) {
        if Favorites.isExistFavorite(element: recipe.title, context: AppDelegate.context) {
            Favorites.deleteFavorites(element: recipe.title, context: AppDelegate.context)
            navigationController?.popViewController(animated: true)
        } else {
            Favorites.createFavorites(with: recipe, context: AppDelegate.context)
            self.loadRecipe()
            self.updateFavoriteIcon()
        }
    }
    
    @IBAction func directionButtonDidTapped(_ sender: Any) {
        guard let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - privates
    
    private func updateFavoriteIcon() {
        if Favorites.isExistFavorite(element: recipe.title, context: AppDelegate.context) {
            favoriteNavigationBarIcon.image = UIImage(systemName: "star.fill")
        } else {
            favoriteNavigationBarIcon.image = UIImage(systemName: "star")
        }
    }
    
    private func loadRecipe() {
        titleLabel.text = recipe.title
        ingredientTextView.text = recipe.ingredients.map { $0+"\n" }.joined()
        timeLabel.text = String(recipe.time)+"m"
        yieldLabel.text = String(recipe.yield)
        if recipe.imageurl.isEmpty {
            imageView.loadFiles(from: recipe.fileName, description: recipe.title)
        } else {
            imageView.load(from: recipe.imageurl, description: recipe.title)
        }
    }
    
    private func createRecipeWithFavori() {
        recipe.title  = favori.title ?? ""
        let ingredient = favori.ingredients
        recipe.ingredients  = ingredient?.components(separatedBy: "\n") ?? [""]
        recipe.time = Int(favori.time)
        recipe.yield = Int(favori.yield)
        recipe.fileName = favori.fileName ?? ""
    }
    
}
