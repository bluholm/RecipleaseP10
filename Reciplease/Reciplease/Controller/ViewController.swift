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
    private let cellIdentifier = "ingredientList"
    //private var keywords = [String]()
    private var keywords = ["lamb","mint"]
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 10.0)
        
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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
    //MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! RecipiesListViewController
        destinationViewController.keyword = keywords
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            keywords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - Extension KeyBoard Should Return

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientTextField.resignFirstResponder()
        return true
    }
}
