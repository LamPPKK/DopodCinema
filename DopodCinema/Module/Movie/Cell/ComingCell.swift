//
//  ComingCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit
import SDWebImage

class ComingCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var averageLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 5
        containerView.dropShadow(offSet: CGSize(width: 0, height: 4), radius: 16)
        
        posterImageView.layer.cornerRadius = 2
        categoryLabel.font = .fontPoppinsMedium(withSize: 12)
        categoryLabel.textColor = Constant.Color.color9CA4AB
        
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        nameLabel.textColor = .black
        
        averageLabel.font = .fontPoppinsMedium(withSize: 12)
        averageLabel.textColor = Constant.Color.colorFACC15
        
        countLabel.font = .fontPoppinsMedium(withSize: 12)
        countLabel.textColor = Constant.Color.color9CA4AB
        
        overviewLabel.font = .fontPoppinsMedium(withSize: 13)
        overviewLabel.textColor = Constant.Color.color78828A
    }
    
    func bindData(_ data: MovieInfo) {
        if let url = URL(string: Utils.getPosterPath(data.poster_path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        }
        
        nameLabel.text = data.original_title
        averageLabel.text = "\(data.vote_average)"
        countLabel.text = "(\(data.vote_count))"
        overviewLabel.text = data.overview
    }

}
