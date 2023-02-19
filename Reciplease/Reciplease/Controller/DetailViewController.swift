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
    var repository = FavoritesRepository()
    var recipeNS = NSManagedObject()
    var recipe = Recipie(title: "", ingredients: [""], time: 0, fileName: "", imageurl: "", yield: 0, url: "")
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.applyGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if recipe.title == "" {
           transferDataFromNSManagedObject()
        }
        self.loadRecipe()
        self.updateFavoriteIcon()
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonDidTapped(_ sender: Any) {
        if repository.isDataExist(title: recipe.title) {
           repository.deleteData(data: recipeNS)
            navigationController?.popViewController(animated: true)
        } else {
            repository.createData(data: recipe)
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
        if repository.isDataExist(title: recipe.title) {
            favoriteNavigationBarIcon.image = UIImage(systemName: "star.fill")
        } else {
            favoriteNavigationBarIcon.image = UIImage(systemName: "star")
        }
    }
    
    private func loadRecipe() {
        titleLabel.text = recipe.title
        ingredientTextView.text = recipe.ingredients.map { $0+"\n" }.joined()
        
        if recipe.imageurl.isEmpty {
            imageView.loadFiles(from: recipe.fileName)
        } else {
            imageView.load(from: recipe.imageurl)
        }
         
        timeLabel.text = String(recipe.time)
        yieldLabel.text = String(recipe.yield)
    }
    
    private func transferDataFromNSManagedObject() {
        recipe.title  = recipeNS.value(forKey: ConstantKey.title) as? String ?? ""
        let ingredient = recipeNS.value(forKey: ConstantKey.ingredients) as? String ?? ""
        recipe.ingredients  = ingredient.components(separatedBy: "\n")
        recipe.time = recipeNS.value(forKey: ConstantKey.time) as? Int ?? 0
        recipe.yield = recipeNS.value(forKey: ConstantKey.yield) as? Int ?? 0
        recipe.fileName = recipeNS.value(forKey: ConstantKey.fileName) as? String ?? ""
    }
    
}
