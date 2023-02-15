//
//  HeaderCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

class HeaderCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerLabel.font = UIFont.fontPoppinsMedium(withSize: 16)
        seeAllButton.setTitleColor(Constant.Color.color9CA4AB, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.fontInterRegular(withSize: 13)
    }

    func setTitle(_ title: String, bottom: CGFloat) {
        headerLabel.text = title
        bottomConstraint.constant = bottom
    }
}
