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
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.layer.cornerRadius = 2
        posterImageView.contentMode = .scaleAspectFill
    }

    func bindData(_ poster: String?) {
        if let url = URL(string: Utils.getPosterPath(poster)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"),
                                        context: nil)
        }
    }
}
