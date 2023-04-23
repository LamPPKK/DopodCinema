//
//  ImageDetailCell.swift
//  Uxim
//
//  Created by The Ngoc on 2022/12/11.
//

import UIKit
import SDWebImage

protocol ImageDetailCellDelegate: AnyObject {
    func showBottomSheet(with selectedImage: UIImage)
}

class ImageDetailCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var detailImageView: UIImageView!
    
    weak var delegate: ImageDetailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        detailImageView.isUserInteractionEnabled = true
        detailImageView.addGestureRecognizer(longPress)
    }

    @objc
    private func longPressed() {
        delegate?.showBottomSheet(with: detailImageView.image ?? UIImage())
    }
    
    func bindData(_ imageObject: ImageInfo) {
        if let url = URL(string: Utils.getPosterPath(imageObject.file_path, size: .w500)) {
            detailImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_movie"))
        } else {
            detailImageView.image = UIImage(named: "ic_movie")
        }
    }
}
