//
//  ViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ingredientTextField: UITextField!
    private let cellIdentifier = "ingredientList"
    private var keywords = [String]()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.addBottomBorder()
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let ingredient = ingredientTextField.text, !ingredient.isEmpty else { return }
        
        if keywords.firstIndex(of: ingredient) != nil {
            print("ERROR to push : ingredient already exist")
        } else {
            keywords.append(ingredient)
            tableView.reloadData()
        }
        ingredientTextField.text?.removeAll()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        keywords.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? RecipesViewController else { return }
        destinationViewController.keyword = keywords
    }
}

    // MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = keywords[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            keywords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Extension KeyBoard Should Return

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientTextField.resignFirstResponder()
        return true
    }
}
