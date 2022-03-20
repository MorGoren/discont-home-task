//
//  GradientView.swift
//  discont
//
//  Created by Mor Goren on 20/03/2022.
//

import UIKit

class GradientView: UIView {
    
    var colors: [CGColor] = [UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 0.2).cgColor, UIColor(red: 88/255, green: 214/255, blue: 86/255, alpha: 0.2).cgColor, UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 0.2).cgColor]
    
    var startX: CGFloat = 0
    var endX: CGFloat = 1
    var startY: CGFloat = 0
    var endY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: startX, y: startY)
        gradientLayer.endPoint = CGPoint(x: endX, y: endY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
