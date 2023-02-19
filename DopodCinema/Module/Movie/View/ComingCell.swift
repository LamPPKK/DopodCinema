//
//  ComingCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

class ComingCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 5
        containerView.dropShadow(offSet: CGSize(width: 0, height: 4), radius: 16)
        
        posterImageView.layer.cornerRadius = 2
        categoryLabel.font = .fontPoppinsMedium(withSize: 12)
        categoryLabel.textColor = Constant.Color.color9CA4AB
        
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        nameLabel.textColor = .black
        
        timeLabel.font = .fontPoppinsMedium(withSize: 13)
        timeLabel.textColor = Constant.Color.color78828A
    }

}
