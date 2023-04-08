//
//  MovieTrailerCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/27.
//

import UIKit

class MovieTrailerCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var trailerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        trailerImageView.contentMode = .scaleAspectFill
        trailerImageView.corner(radius: 5)
    }

    func bindData(_ data: VideoInfo) {
        let thumbnailURL = URL(string: Constant.Network.THUMBNAIL_YOUTUBE_URL +
                               data.key +
                               Constant.Network.THUMBNAIL_MAX_YOUTUBE)
        trailerImageView.sd_setImage(with: thumbnailURL,
                                     placeholderImage: UIImage(named: "ic_loading"))
    }
}
