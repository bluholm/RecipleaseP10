//
//  UIViewExtension.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-12.
//

import UIKit

// MARK: - UIView Extension

extension UIView {
    
    func applyGradient() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.type = .axial
            gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
            gradientLayer.frame = self.bounds
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
