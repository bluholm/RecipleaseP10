//
//  ViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ingredientTextField: UITextField!
    private var keywords = [String]()
    private let cellIdentifier = "ingredientList"
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ingredientTextField.addBottomBorder()
        
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let ingredient = ingredientTextField.text, !ingredient.isEmpty else {
            return
        }
        keywords.append(ingredient)
        ingredientTextField.text = ""
        tableView.reloadData()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        keywords.removeAll()
        tableView.reloadData()
    }
    
}

    //MARK: -  UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = keywords[indexPath.row]
        return cell
    }
}
