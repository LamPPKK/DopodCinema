//
//  ActorCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit
import SDWebImage

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
    
    func bindData(_ data: ActorInfo) {
        if let url = URL(string: Utils.getProfilePath(data.profile_path)) {
            actorImageView.sd_setImage(with: url,
                                       placeholderImage: UIImage(named: "ic_loading"))
        } else {
            actorImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = data.name
    }
    
    func bindData(_ saveInfo: SavedInfo) {
        if let url = URL(string: Utils.getProfilePath(saveInfo.path)) {
            actorImageView.sd_setImage(with: url,
                                       placeholderImage: UIImage(named: "ic_loading"))
        } else {
            actorImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = saveInfo.name
    }
}
