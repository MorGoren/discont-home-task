//
//  HeaderCell.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var background: UIView!
    
    func setTitle(title: String, imageName: String) {
        self.title.text = title
        self.image.image = UIImage(systemName: imageName)
    }
}
