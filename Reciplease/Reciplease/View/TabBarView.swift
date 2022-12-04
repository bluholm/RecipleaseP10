//
//  TabBarView.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        customizeTabBarView()
    }
    
    //MARK: - Private
    
    private func customizeTabBarView() {
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        tabBarController?.tabBar.barTintColor = UIColor.brown
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .default
    }

}
