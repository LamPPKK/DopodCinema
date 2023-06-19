//
//  HeaderCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

protocol HeaderCellDelegate: NSObjectProtocol {
    func didSelectedSeeAllMovie(section: MovieSectionType)
    func didSelectedSeeAllTV(section: TVSectionType)
    func didSelectedSeeAllDiscover(section: DiscoverSectionType)
}

class HeaderCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    weak var delegate: HeaderCellDelegate?
    
    private var movieSection: MovieSectionType?
    private var tvSection: TVSectionType?
    private var discoverSection: DiscoverSectionType?
    
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
                  tvSection: TVSectionType? = nil,
                  discoverSection: DiscoverSectionType? = nil) {
        headerLabel.text = title
        bottomConstraint.constant = bottom
        seeAllButton.isHidden = isHideSeeAll
        self.movieSection = movieSection
        self.tvSection = tvSection
        self.discoverSection = discoverSection
    }
    
    @IBAction func didToSeeAll() {
        if let movieSection = movieSection {
            delegate?.didSelectedSeeAllMovie(section: movieSection)
        } else if let tvSection = tvSection {
            delegate?.didSelectedSeeAllTV(section: tvSection)
        } else if let section = discoverSection {
            delegate?.didSelectedSeeAllDiscover(section: section)
        }
    }
}
