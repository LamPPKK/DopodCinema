//
//  ImageCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/26.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.corner(radius: 5)
    }

    func bindData(_ path: String?) {
        if let url = URL(string: Utils.getPosterPath(path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
    }
    
    func bindWallpaper(_ path: String) {
        if let url = URL(string: path) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
    }
}
