//
//  HeaderShowTime.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/18.
//

import UIKit

class HeaderShowTime: BaseViewController<HeaderShowTimeViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindingData()
    }

    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        
        setupSubHeader(with: "Showtimes")
        
        posterImageView.corner(radius: 8)
        posterImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .fontPoppinsSemiBold(withSize: 24)
        nameLabel.textColor = Constant.Color.color2B2F31
        
        genresLabel.font = .fontPoppinsRegular(withSize: 13)
        genresLabel.textColor = Constant.Color.color2B2F31
        
        ratingLabel.font = .fontPoppinsRegular(withSize: 13)
        ratingLabel.textColor = Constant.Color.color2B2F31
        
        timeLabel.font = .fontPoppinsRegular(withSize: 13)
        timeLabel.textColor = Constant.Color.color2B2F31
    }

    private func bindingData() {
        if let url = URL(string: Utils.getPosterPath(viewModel.getMovieDetailInfo().poster_path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        }
        
        genresLabel.text = Utils.getGenresString(from: viewModel.getMovieDetailInfo().genres, separator: " • ")
        ratingLabel.text = "\(viewModel.getMovieDetailInfo().vote_average.format(f: 1))/10"
        nameLabel.text = viewModel.getMovieDetailInfo().original_title
        let (hour, min) = Utils.getHourMin(from: viewModel.getMovieDetailInfo().runtime)
        timeLabel.text = "\(hour)h\(min)m"
    }
}
