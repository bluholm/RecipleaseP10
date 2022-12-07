//
//  RecipiesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

final class RecipiesListViewController: UIViewController {

    //MARK: - Extension UITableViewDataSource
    
    @IBOutlet var toggleActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    private var recipiesList = [Recipie]()
    var keyword = [String]()
    private let defaultIngredient = "tomato,basil"
    private let cellIdentifier = "cellRecipiesIdentification"
    private let model = RecipiesService()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator.isHidden = false
        loadingLabel.isHidden = false
        getRecipies()
    }
    
    //MARK: - Privates
    
    private func  setIngredients(keywords: [String]) {
        if !keywords.isEmpty {
            var ingredients = keywords.map { $0+"," }.joined()
            ingredients.removeLast()
            model.ingredients = ingredients
        } else {
            model.ingredients = defaultIngredient
        }
    }
    
    private func getRecipies() {
        setIngredients(keywords: keyword)
        model.getRecipies { result in
            switch result {
            case .success(let value):
                value.hits.forEach { hit in
                    let recipie = Recipie(title: hit.recipe.label,
                                          ingredients: hit.recipe.ingredientLines,
                                          time: Double(hit.recipe.totalTime),
                                          image: hit.recipe.image,
                                          yield: String(hit.recipe.yield)
                    )
                    self.recipiesList.append(recipie)
                }
                self.toggleActivityIndicator.isHidden = true
                self.loadingLabel.isHidden = true
                self.tableView.reloadData()
                
            case .failure(.errorNil):
                print("errorNIl")
            case .failure(.decoderJSON):
                print("decoderJSON")
            case .failure(.statusCode):
                print("StutsCodeError")
            }
        }
    }
}

//MARK: - Extension UITableViewDataSource

extension RecipiesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipiesTableViewCell else {
           return UITableViewCell()
        }
        var time: String {
            if recipiesList[indexPath.row].time == 0.0 {
                return "N/A"
            } else {
                return String(Int(recipiesList[indexPath.row].time))+"m"
            }
        }

        cell.configure(image: recipiesList[indexPath.row].image,
                       title: recipiesList[indexPath.row].title,
                       subtitle: recipiesList[indexPath.row].ingredients[0],
                       note: recipiesList[indexPath.row].yield,
                       time: time
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "resume") as? ResumeViewController {
            vc.recipe = recipiesList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
