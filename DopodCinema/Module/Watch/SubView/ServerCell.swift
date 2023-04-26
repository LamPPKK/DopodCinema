//
//  ServerCell.swift
//  Uxim
//
//  Created by The Ngoc on 2023/01/18.
//

import UIKit

class ServerCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var serverLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 6
        containerView.backgroundColor = .gray
        
        serverLabel.font = .fontPoppinsMedium(withSize: 13)
        serverLabel.textColor = .white
    }
    
    func bindData(with index: Int) {
        serverLabel.text = "#" + String(index + 1)
    }
}
