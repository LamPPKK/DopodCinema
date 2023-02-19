//
//  ActorCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

class ActorCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var actorImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        actorImageView.layer.cornerRadius = 6
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        nameLabel.textColor = .black
    }

}
