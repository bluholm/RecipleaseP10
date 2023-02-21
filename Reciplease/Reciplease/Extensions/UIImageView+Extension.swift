//
//  UIViewExtension.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-12.
//

import UIKit

// MARK: - UIImage Extension

extension UIImageView {
    
    func load(from urlImageString: String?, description: String) {
        guard let urlImageString = urlImageString else { return }
        guard let urlImage = URL(string: urlImageString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    image.accessibilityLabel = description
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    self?.image = UIImage(named: "ImageDefault1024x768" + ".jpg")
                }
            }
        }
    }
}

extension UIImageView {
    
    func loadFiles(from nameFile: String, description: String) {
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameFile)
        self.image = UIImage(contentsOfFile: yourProjectImagesPath)
        image?.accessibilityLabel = description
    }
}
