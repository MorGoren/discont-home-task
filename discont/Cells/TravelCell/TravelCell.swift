//
//  TravelCell.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class TravelCell: UICollectionViewCell {

    @IBOutlet weak var travelImage: FAShimmerImageView!
    @IBOutlet weak var title: FAShimmerLabelView!
    
    private var data: RssItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadow()
    }

    func setData(data: RssItem) {
        self.data = data
        
        travelImage.load(stringUrl: data.imageUrl)
        stopShimmer(view: travelImage)
        
        title.text = data.title
        stopShimmer(view: title)
        
        layoutIfNeeded()
    }
    
    private func stopShimmer(view: UIView) {
        view.stopShimmering()
        view.backgroundColor = .clear
    }
    
}
