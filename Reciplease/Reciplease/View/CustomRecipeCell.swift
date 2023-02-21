//
//  RecipiesTableViewCell.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-04.
//

import UIKit

class CustomRecipeCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var gradient: UIView!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradient.applyGradient()
    }
    
    // MARK: - Pubic
    // swiftlint: disable function_parameter_count
    func configure(fileName: String, imageURL: String, title: String, subtitle: String, yield: String, time: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        noteLabel.text = yield
        timeLabel.text = time
        if imageURL.isEmpty {
            
            imageBackground.loadFiles(from: fileName, description: title)
            
        } else {
            imageBackground.load(from: imageURL, description: title)
        }
    }
}
