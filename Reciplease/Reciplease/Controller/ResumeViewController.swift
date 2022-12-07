//
//  ResumeViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-06.
//

import UIKit

final class ResumeViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var gradientView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var yieldLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    var repository = FavoritesRepository()
    var recipe = Recipie(title: "",
                         ingredients: [""],
                         time: 0.0,
                         image: "",
                         yield: "")
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.applyGradient()
        loadRecipie()
    }
    
    //MARK: - privates
    
    private func loadRecipie() {
        var ingredients: String {
            recipe.ingredients.map { $0+"\n" }.joined()
        }
        
        imageView.load(from: recipe.image)
        titleLabel.text = recipe.title
        timeLabel.text = String(Int(recipe.time))+"m"
        yieldLabel.text = recipe.yield
        ingredientTextView.text = ingredients
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonDidTapped(_ sender: Any) {
        repository.saveData(favorite: recipe)
    }
    
    @IBAction func directionButtonDidTapped(_ sender: Any) {}
}
