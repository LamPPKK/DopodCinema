//
//  TimesCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

class TimesCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = Constant.Color.color3D5BF6
        
        descLabel.font = UIFont.fontPoppinsSemiBold(withSize: 16)
    }
}
