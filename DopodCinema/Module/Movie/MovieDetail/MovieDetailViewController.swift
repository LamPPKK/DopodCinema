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
    @IBOutlet private weak var arrowButton: UIButton!
    @IBOutlet private weak var trailerLabel: UILabel!
    @IBOutlet private weak var trailerCollectionView: UICollectionView!
    @IBOutlet private weak var movieScreenShotsLabel: UILabel!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var startingLabel: UILabel!
    @IBOutlet private weak var startingCollectionView: UICollectionView!
    @IBOutlet private weak var similarLabel: UILabel!
    @IBOutlet private weak var similarCollectionView: UICollectionView!
    
    // MARK: - Properties
    let ImageCellIdentity: String = "ImageCell"
    let TrailerCellIdentity: String = "TrailerCell"
    let StartingCellIdentity: String = "StartingCell"
    
    private var isCloseTime: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
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
        
        trailerLabel.font = .fontPoppinsSemiBold(withSize: 16)
        trailerLabel.textColor = Constant.Color.color2B2F31
        
        movieScreenShotsLabel.font = .fontPoppinsSemiBold(withSize: 16)
        movieScreenShotsLabel.textColor = Constant.Color.color2B2F31
        
        startingLabel.font = .fontPoppinsSemiBold(withSize: 16)
        startingLabel.textColor = Constant.Color.color2B2F31
        
        similarLabel.font = .fontPoppinsSemiBold(withSize: 16)
        similarLabel.textColor = Constant.Color.color2B2F31
    }
    
    private func setupCollectionView() {
        trailerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        trailerCollectionView.dataSource = self
        trailerCollectionView.delegate = self
        trailerCollectionView.register(UINib(nibName: TrailerCellIdentity, bundle: nil), forCellWithReuseIdentifier: TrailerCellIdentity)
        trailerCollectionView.tag = CollectionViewTag.trailer.rawValue
        
        imageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
        imageCollectionView.tag = CollectionViewTag.screenshots.rawValue
        
        startingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        startingCollectionView.dataSource = self
        startingCollectionView.delegate = self
        startingCollectionView.register(UINib(nibName: StartingCellIdentity, bundle: nil), forCellWithReuseIdentifier: StartingCellIdentity)
        startingCollectionView.tag = CollectionViewTag.starting.rawValue
        
        similarCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
        similarCollectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
        similarCollectionView.tag = CollectionViewTag.similarmovies.rawValue
    }
    
    private func bindData() {
        let movieDetailInfo = viewModel.movieDetailInfo
        
        setupSubHeader(with: movieDetailInfo.original_title,
                       isDetail: true)
        
        if let url = URL(string: Utils.getPosterPath(movieDetailInfo.poster_path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        }
        
        nameLabel.text = movieDetailInfo.original_title
        genresLabel.text = Utils.getGenresString(from: movieDetailInfo.genres, separator: " • ")
        ratingLabel.text = "\(movieDetailInfo.vote_average.format(f: 1))/10"
        let (hour, min) = Utils.getHourMin(from: movieDetailInfo.runtime)
        timeLabel.text = "\(hour)h\(min)m"
        overViewLabel.text = movieDetailInfo.overview
    }
    
    // MARK: - IBAction
    @IBAction func didArrow() {
        isCloseTime = !isCloseTime
        
        if isCloseTime {
            UIView.animateKeyframes(withDuration: 1,
                                    delay: 0, animations: {
                self.checkoutView.frame.origin.x = self.view.frame.maxX - 50
            }, completion: { _ in
                self.arrowButton.setImage(UIImage(named: "ic_ar_left_white"), for: .normal)
            })
        } else {
            UIView.animateKeyframes(withDuration: 1,
                                    delay: 0, animations: {
                self.checkoutView.frame.origin.x = self.view.frame.maxX - self.checkoutView.frame.width
            }, completion: { _ in
                self.arrowButton.setImage(UIImage(named: "ic_ar_right_white"), for: .normal)
            })
        }
    }
}
