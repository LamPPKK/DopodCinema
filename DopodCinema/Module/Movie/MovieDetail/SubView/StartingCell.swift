//
//  StartingCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/01.
//

import UIKit

class StartingCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        profileImageView.corner(radius: profileImageView.frame.height / 2)
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .fontPoppinsRegular(withSize: 13)
        nameLabel.textColor = Constant.Color.color55595A
    }

    func bindData(_ data: CastInfo) {
        if let url = URL(string: Utils.getPosterPath(data.profile_path)) {
            profileImageView.sd_setImage(with: url,
                                         placeholderImage: UIImage(named: "ic_loading"))
        } else {
            profileImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = data.name
    }
}
