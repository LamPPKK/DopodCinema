//
//  TrailerCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/07.
//

import UIKit

class TrailerCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var trailerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        trailerImageView.contentMode = .scaleAspectFill
        trailerImageView.corner(radius: 5)
        
        nameLabel.font = .fontPoppinsSemiBold(withSize: 14)
        nameLabel.textColor = Constant.Color.color2B2F31
    }

    func bindData(_ data: VideoInfo) {
        let thumbnailURL = URL(string: Constant.Network.THUMBNAIL_YOUTUBE_URL +
                               data.key +
                               Constant.Network.THUMBNAIL_MAX_YOUTUBE)
        trailerImageView.sd_setImage(with: thumbnailURL,
                                     placeholderImage: UIImage(named: "ic_loading"))
        
        nameLabel.text = data.name
    }
}
