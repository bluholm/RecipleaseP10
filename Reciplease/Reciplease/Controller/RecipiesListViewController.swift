//
//  RecipiesListViewController.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

class RecipiesListViewController: UIViewController {

    //MARK: - Extension UITableViewDataSource
    
    var recipies = [String]()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

//MARK: - Extension UITableViewDataSource

extension RecipiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
