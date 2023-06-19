//
//  DiscoverCheckoutCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/18.
//

import UIKit

class DiscoverCheckoutCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.corner(radius: 12)
        containerView.backgroundColor = Constant.Color.color4E69F7
        
        contentLabel.text = "Check out\nTrending Wallpaper"
        contentLabel.textColor = .white
        contentLabel.font = .fontPoppinsSemiBold(withSize: 24)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        
        seeMoreButton.corner(radius: seeMoreButton.frame.height / 2)
        seeMoreButton.backgroundColor = .white
        seeMoreButton.setTitle("See more", for: .normal)
        seeMoreButton.setTitleColor(Constant.Color.color4E69F7, for: .normal)
    }
}
