//
//  HeaderCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

class HeaderCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var seeAllButton: UIButton!
        
    private var movieSection: MovieSectionType?
    private var tvSection: TVSectionType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerLabel.font = UIFont.fontPoppinsMedium(withSize: 16)
        seeAllButton.setTitleColor(Constant.Color.color9CA4AB, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.fontInterRegular(withSize: 13)
    }

    func setTitle(_ title: String,
                  bottom: CGFloat,
                  isHideSeeAll: Bool = false,
                  movieSection: MovieSectionType? = nil,
                  tvSection: TVSectionType? = nil) {
        headerLabel.text = title
        bottomConstraint.constant = bottom
        seeAllButton.isHidden = isHideSeeAll
        self.movieSection = movieSection
        self.tvSection = tvSection
    }
    
    @IBAction func didToSeeAll() {
        
    }
}
