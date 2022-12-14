//
//  RecipiesTableViewCell.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-04.
//

import UIKit

class CustomRecipeCell: UITableViewCell {

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
    func configure(fileName: String, imageURL: String, title: String, subtitle: String, yield: String, time: String) {
        if imageURL.isEmpty {
            imageBackground.loadFiles(from: fileName)
            
        } else {
            imageBackground.load(from: imageURL)
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
        noteLabel.text = yield
        timeLabel.text = time
    }
}
