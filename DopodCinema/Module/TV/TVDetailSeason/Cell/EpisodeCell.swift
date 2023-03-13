//
//  EpisodeCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/13.
//

import UIKit

class EpisodeCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.corner(radius: 8)
        
        nameLabel.textColor = Constant.Color.color3D5BF6
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        
        overViewLabel.textColor = Constant.Color.color55595A
        overViewLabel.font = .fontPoppinsRegular(withSize: 12)
    }
    
    func bindData(_ data: EpiscodeInfo) {
        if let url = URL(string: Utils.getPosterPath(data.still_path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = data.name
        overViewLabel.text = data.overview
    }
}
