//
//  RecipiesTableViewCell.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-04.
//

import UIKit

class RecipiesTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var gradient: UIView!
    
    //MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradient.applyGradient()
    }
    
    //MARK: - Pubic
    func configure(image: String, title: String, subtitle: String, note: String, time: String) {
        imageBackground.load(urlImageString: image)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        noteLabel.text = note
        timeLabel.text = time
        
    }
}


//MARK: - UIView Extension

extension UIView {
    func applyGradient() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.type = .axial
            gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,UIColor.black.withAlphaComponent(0.0).cgColor]
            gradientLayer.frame = self.bounds
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            
            self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImageView {
    /// Load an image from his URL
    func load(urlImageString: String?) {
        guard let urlImageString = urlImageString else { return }
        guard let urlImage = URL(string: urlImageString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
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