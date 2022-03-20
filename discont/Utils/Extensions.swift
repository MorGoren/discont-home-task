//
//  Extensions.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import Foundation
import UIKit

var lastLink: String = .empty

extension String {
    static let empty = ""
}

extension UIImageView {
    func load(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        let data = try? Data(contentsOf: url)
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
}

extension UIView {
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
}
