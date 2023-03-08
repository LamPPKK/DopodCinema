//
//  TopCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

import UIKit
import SDWebImage

class TopCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.corner(radius: 16)

        posterImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .fontPoppinsBold(withSize: 14)
        nameLabel.textColor = .white
        
        categoryView.backgroundColor = .white.withAlphaComponent(0.2)
        categoryView.corner(radius: categoryView.frame.height / 2)
        
        categoryLabel.font = .fontPoppinsMedium(withSize: 10)
        categoryLabel.textColor = .white        
    }
    
    func bindData(_ poster: String?,
                  category: String,
                  name: String) {
        if let url = URL(string: Utils.getPosterPath(poster)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        }
        
        categoryLabel.text = category
        nameLabel.text = name
    }
}
