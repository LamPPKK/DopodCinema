//
//  DiscoverWallpaperCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/17.
//

import UIKit

class DiscoverWallpaperCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var discoverWallpaperImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        discoverWallpaperImageView.contentMode = .scaleAspectFill
        discoverWallpaperImageView.corner(radius: 12)
    }
}
