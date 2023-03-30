//
//  TimeCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/27.
//

import UIKit

class TimeCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.corner(radius: 3)
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = Constant.Color.color55595A.cgColor
        
        timeLabel.textColor = Constant.Color.color2B2F31
        timeLabel.font = .fontPoppinsRegular(withSize: 12)
    }

    func bindData(_ time: String) {
        timeLabel.text = time
    }
}
