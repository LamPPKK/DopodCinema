//
//  NewCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

class NewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.layer.cornerRadius = 2
    }

}
