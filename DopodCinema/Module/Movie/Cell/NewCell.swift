//
//  NewCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit
import SDWebImage

class NewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.layer.cornerRadius = 2
        posterImageView.contentMode = .scaleAspectFill
    }

    func bindData(_ poster: String?) {
        if let url = URL(string: Utils.getPosterPath(poster)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
    }
    
    func bindWallpaper(_ wallpaperURL: String) {
        if let url = URL(string: wallpaperURL) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
    }
}
