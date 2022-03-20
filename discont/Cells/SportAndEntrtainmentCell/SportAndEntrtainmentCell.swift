//
//  SportAndEntrtainmentCell.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class SportAndEntrtainmentCell: UITableViewCell {

    @IBOutlet weak var cellImage: FAShimmerImageView!
    @IBOutlet weak var title: FAShimmerLabelView!
    @IBOutlet weak var cellDescription: FAShimmerLabelView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imageShimmerView: FAShimmerView!
    
    private var data: RssItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadow()
    }

    func setData(data: RssItem, backgroundColor: UIColor) {
        self.data = data
        
        cellImage.load(stringUrl: data.imageUrl)
        stopShimmer(view: cellImage)
        imageShimmerView.isHidden = true
        
        title.text = data.title
        stopShimmer(view: title)
        
        cellDescription.text = data.description
        stopShimmer(view: cellDescription)
        
        background.layer.cornerRadius = 5
        background.backgroundColor = backgroundColor
        
        layoutIfNeeded()
    }
    
    private func stopShimmer(view: UIView) {
        view.stopShimmering()
        view.backgroundColor = .clear
    }
}
