//
//  PopularCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit
import SDWebImage

class PopularCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var averageLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - private functions
    private func setupUI() {
        iconImageView.layer.cornerRadius = 8
        iconImageView.contentMode = .scaleAspectFill
        
        categoryLabel.font = .fontPoppinsMedium(withSize: 12)
        categoryLabel.textColor = Constant.Color.color9CA4AB
        
        nameLabel.font = .fontPoppinsBold(withSize: 16)
        nameLabel.textColor = .black
        
        averageLabel.font = .fontPoppinsMedium(withSize: 12)
        averageLabel.textColor = Constant.Color.colorFACC15
        
        countLabel.font = .fontPoppinsMedium(withSize: 12)
        countLabel.textColor = Constant.Color.color9CA4AB
    }
    
    func bindData(_ data: MovieInfo, genres: [GenreInfo]) {
        if let url = URL(string: Utils.getPosterPath(data.poster_path)) {
            iconImageView.sd_setImage(with: url,
                                      placeholderImage: UIImage(named: "ic_loading"))
        } else {
            iconImageView.image = UIImage(named: "ic_loading")
        }
        
        categoryLabel.text = Utils.getNameGenres(from: data.genre_ids, genres: genres, separator: ", ")
        nameLabel.text = data.original_title
        averageLabel.text = "\(data.vote_average)"
        countLabel.text = "(\(data.vote_count))"
    }
    
    func bindData(_ data: TVShowInfo, genres: [GenreInfo]) {
        if let url = URL(string: Utils.getPosterPath(data.poster_path)) {
            iconImageView.sd_setImage(with: url,
                                      placeholderImage: UIImage(named: "ic_loading"))
        } else {
            iconImageView.image = UIImage(named: "ic_loading")
        }
        
        categoryLabel.text = Utils.getNameGenres(from: data.genre_ids, genres: genres, separator: ", ")
        nameLabel.text = data.name
        averageLabel.text = "\(data.vote_average)"
        countLabel.text = "(\(data.vote_count))"
    }
}
