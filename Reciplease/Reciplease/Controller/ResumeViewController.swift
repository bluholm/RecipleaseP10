//
//  ResumeViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-06.
//

import UIKit
import CoreData

class ResumeViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var gradientView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var yieldLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    var recipe = Recipie(title: "",
                         ingredients: [""],
                         time: 0.0,
                         image: "",
                         yield: "")
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.applyGradient()
        
        
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()

        do {
            guard let result = try? AppDelegate.viewContext.fetch(request) else {
                return
            }
            for data in result {
                debugPrint(data.value(forKey: "name") as? String ?? "")
            }
        } catch let error as NSError {
            debugPrint(error)
        }
        
        
        imageView.load(from: recipe.image)
        titleLabel.text = recipe.title
        timeLabel.text = String(Int(recipe.time))+"m"
        yieldLabel.text = recipe.yield
        var ingredients: String {
            recipe.ingredients.map { $0+"\n" }.joined()
        }
        ingredientTextView.text = ingredients
        
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonDidTapped(_ sender: Any) {
        let favorites = Favorites(context: AppDelegate.viewContext)
        favorites.title = "test"
        do {
            try AppDelegate.viewContext.save()
            print("save")
        } catch {
            print("error while saving \(favorites)")
        }
    }
    
    @IBAction func directionButtonDidTapped(_ sender: Any) {
       
        
    }
    
}
