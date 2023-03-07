//
//  CategoryCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    // MARK: - Properties
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 34 / 2
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Constant.Color.colorE3E9ED.cgColor
        
        valueLabel.textColor = Constant.Color.color9CA4AB
        valueLabel.font = .fontInterRegular(withSize: 13)
    }

    func bindData(_ text: String) {
        valueLabel.text = text
    }
    
    func bindData(_ data: CategoryInfo) {
        valueLabel.text = data.name
        containerView.backgroundColor = data.isSelected ? Constant.Color.color3D5BF6 : UIColor.white
        valueLabel.textColor = data.isSelected ? UIColor.white : Constant.Color.color9CA4AB
    }
}
