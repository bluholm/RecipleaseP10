//
//  RecipiesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

class RecipiesListViewController: UIViewController {

    //MARK: - Extension UITableViewDataSource
    
    private var recipies = [String]()
    private let cellIdentifier = "cellRecipiesIdentification"
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipies.append("Pizza Margarita")
        recipies.append("Entree tomates basil")
    }
}

//MARK: - Extension UITableViewDataSource

extension RecipiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipiesTableViewCell else {
           return UITableViewCell()
        }
        //recipies[indexPath.row]
        cell.configure(image: "", title: "title", subtitle: "vide", note: "2.5k", time: "25m")
        return cell
    }
}
