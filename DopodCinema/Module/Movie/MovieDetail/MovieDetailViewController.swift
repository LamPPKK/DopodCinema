//
//  MovieDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/23.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var playView: UIView!
    @IBOutlet private weak var playLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var thePlotLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var checkoutView: UIView!
    @IBOutlet private weak var checkoutLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindData()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        
        posterImageView.corner(radius: 8)
        posterImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .fontPoppinsSemiBold(withSize: 24)
        nameLabel.textColor = Constant.Color.color2B2F31
        
        playView.layer.cornerRadius = playView.frame.height / 2
        playView.backgroundColor = Constant.Color.color3D5BF6
        
        playLabel.text = "Play movie"
        playLabel.font = .fontPoppinsMedium(withSize: 13)
        playLabel.textColor = .white
        
        genresLabel.font = .fontPoppinsRegular(withSize: 13)
        genresLabel.textColor = Constant.Color.color2B2F31
        
        thePlotLabel.font = .fontPoppinsSemiBold(withSize: 16)
        thePlotLabel.textColor = Constant.Color.color2B2F31
        
        overViewLabel.font = .fontPoppinsRegular(withSize: 14)
        overViewLabel.textColor = Constant.Color.color9CA4AB
        
        ratingLabel.font = .fontPoppinsRegular(withSize: 13)
        ratingLabel.textColor = Constant.Color.color2B2F31
        
        timeLabel.font = .fontPoppinsRegular(withSize: 13)
        timeLabel.textColor = Constant.Color.color2B2F31
        
        checkoutView.backgroundColor = Constant.Color.color3D5BF6
        checkoutView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 100)
        
        checkoutLabel.text = "Check out\nmovie showtime"
        checkoutLabel.textColor = .white
        checkoutLabel.font = .fontPoppinsSemiBold(withSize: 13)
    }
    
    private func bindData() {
        let movieDetailInfo = viewModel.movieDetailInfo
        
        setupSubHeader(with: movieDetailInfo.original_title)
        
        if let url = URL(string: Utils.getPosterPath(movieDetailInfo.poster_path, size: .w342)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"),
                                        context: nil)
        }
        
        nameLabel.text = movieDetailInfo.original_title
        genresLabel.text = Utils.getGenresString(from: movieDetailInfo.genres)
        ratingLabel.text = "\(movieDetailInfo.vote_average.format(f: 1))/10"
        let (hour, min) = Utils.getHourMin(from: movieDetailInfo.runtime)
        timeLabel.text = "\(hour)h\(min)m"
        overViewLabel.text = movieDetailInfo.overview
    }
}
