//
//  ExtensionsView.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-02.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        let color:UIColor = .systemGray5
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
