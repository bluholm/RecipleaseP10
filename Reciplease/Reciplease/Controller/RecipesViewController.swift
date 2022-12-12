//
//  RecipiesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

final class RecipesViewController: UIViewController {

    //MARK: - Properties    
    @IBOutlet var toggleActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    private var recipiesList = [Recipie]() {
        didSet {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }
    }
    var keyword = [String]()
    private let defaultIngredient = "tomato,basil"
    private let cellIdentifier = "cellRecipiesIdentification"
    private let model = RecipiesService()
    var nextUrlCode = ""
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        self.showActivityIndicator(true)
        self.fetchRecipes()
    }
    
    //MARK: - Privates
    
    private func showActivityIndicator(_ isHidden: Bool) {
        tableView.isHidden = isHidden
        toggleActivityIndicator.isHidden = !isHidden
        loadingLabel.isHidden = !isHidden
    }
    
    private func setIngredients(keywords: [String]) {
        if !keywords.isEmpty {
            var ingredients = keywords.map { $0+"," }.joined()
            ingredients.removeLast()
            model.ingredients = ingredients
        } else {
            model.ingredients = defaultIngredient
        }
    }
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    private func fetchRecipes() {
        setIngredients(keywords: keyword)
        model.getRecipies{ [weak self] result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    value.hits.forEach { hit in
                        let recipie = Recipie(title: hit.recipe.label,
                                              ingredients: hit.recipe.ingredientLines,
                                              time: Int(hit.recipe.totalTime),
                                              fileName: String.uniqueFilename(withPrefix: "IMG"),
                                              imageurl: hit.recipe.image,
                                              yield: Int(hit.recipe.yield),
                                              url: hit.recipe.url)
                        self?.recipiesList.append(recipie)
                    }
                    
                    self?.showActivityIndicator(false)
                    let nextUrl = value.links.next.href
                    self?.nextUrlCode = (self?.getQueryStringParameter(url: nextUrl, param: "_cont")!)!
                }
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

extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomRecipeCell else {
           return UITableViewCell()
        }
        var time: String {
            if recipiesList[indexPath.row].time == 0 {
                return "N/A"
            } else {
                return String(Int(recipiesList[indexPath.row].time))+"m"
            }
        }
        cell.configure(fileName: "",
                        imageURL: recipiesList[indexPath.row].imageurl,
                       title: recipiesList[indexPath.row].title,
                       subtitle: recipiesList[indexPath.row].ingredients[0],
                       yield: String(recipiesList[indexPath.row].yield),
                       time: time
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "resume") as? DetailViewController {
            vc.recipe = recipiesList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Extensions UITableViewDataSourcePrefetching

extension RecipesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let filter = indexPaths.filter({ $0.row >= recipiesList.count-1 })
        filter.forEach {_ in
            self.fetchRecipes()
        }
    }
}
