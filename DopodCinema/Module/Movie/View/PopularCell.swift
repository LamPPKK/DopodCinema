//
//  PopularCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

class PopularCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - private functions
    private func setupUI() {
        iconImageView.layer.cornerRadius = 8
        
        categoryLabel.font = .fontPoppinsMedium(withSize: 12)
        categoryLabel.textColor = Constant.Color.color9CA4AB
        
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        nameLabel.textColor = .black
        
        timeLabel.font = .fontPoppinsMedium(withSize: 13)
        timeLabel.textColor = Constant.Color.color78828A
    }
}
