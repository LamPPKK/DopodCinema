//
//  SeasonCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/12.
//

import UIKit
import SDWebImage

class SeasonCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.borderColor = Constant.Color.color3D5BF6.cgColor
        containerView.corner(radius: 8)
        nameLabel.textColor = .white
        nameLabel.font = .fontPoppinsRegular(withSize: 13)
        
    }
    
    func bindData(_ data: SeasonObject) {
        if let url = URL(string: Utils.getPosterPath(data.posterPath)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = data.name
        
        if data.isSelected {
            selectedSeason()
        } else {
            deSelectedSeason()
        }
        
        gradientLayer.frame = self.bounds
        posterImageView.layer.addSublayer(gradientLayer)
    }
    
    private func selectedSeason() {
        containerView.layer.borderWidth = 3
        gradientLayer.colors = [
            Constant.Color.color3D5BF6.withAlphaComponent(0).cgColor,
            Constant.Color.color3D5BF6.cgColor
        ]
    }
    
    private func deSelectedSeason() {
        containerView.layer.borderWidth = 0
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.cgColor
        ]
    }
}
