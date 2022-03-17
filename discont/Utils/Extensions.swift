//
//  Extensions.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import Foundation
import UIKit

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
