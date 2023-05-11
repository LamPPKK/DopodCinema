//
//  TVGeneralViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/10.
//

import UIKit

protocol TVGeneralViewControllerDelegate: NSObjectProtocol {
    func gotoYoutubeScreen(_ key: String)
    func gotoScreenShot(_ index: Int)
    func gotoActorDetailScreen(_ id: Int)
    func gotoMovieDetailScreen(_ id: Int)
    func gotoTrailerScreen()
}

class TVGeneralViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var thePlotLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var trailerLabel: UILabel!
    @IBOutlet private weak var trailerCollectionView: UICollectionView!
    @IBOutlet private weak var heightTrailerView: NSLayoutConstraint!
    @IBOutlet private weak var movieScreenShotsLabel: UILabel!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var heightImageView: NSLayoutConstraint!
    @IBOutlet private weak var startingLabel: UILabel!
    @IBOutlet private weak var startingCollectionView: UICollectionView!
    @IBOutlet private weak var heightStartingView: NSLayoutConstraint!
    @IBOutlet private weak var similarLabel: UILabel!
    @IBOutlet private weak var similarCollectionView: UICollectionView!
    @IBOutlet private weak var heightSimilarView: NSLayoutConstraint!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    // MARK: - Properties
    let ImageCellIdentity: String = "ImageCell"
    let TrailerCellIdentity: String = "MovieTrailerCell"
    let StartingCellIdentity: String = "StartingCell"
    
    weak var delegate: TVGeneralViewControllerDelegate?
    
    var tvDetailInfo: TVShowDetailInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        bindData()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        thePlotLabel.font = .fontPoppinsSemiBold(withSize: 16)
        thePlotLabel.textColor = Constant.Color.color2B2F31
        
        overViewLabel.font = .fontPoppinsRegular(withSize: 14)
        overViewLabel.textColor = Constant.Color.color9CA4AB
        
        trailerLabel.font = .fontPoppinsSemiBold(withSize: 16)
        trailerLabel.textColor = Constant.Color.color2B2F31
        
        movieScreenShotsLabel.font = .fontPoppinsSemiBold(withSize: 16)
        movieScreenShotsLabel.textColor = Constant.Color.color2B2F31
        
        startingLabel.font = .fontPoppinsSemiBold(withSize: 16)
        startingLabel.textColor = Constant.Color.color2B2F31
        
        similarLabel.font = .fontPoppinsSemiBold(withSize: 16)
        similarLabel.textColor = Constant.Color.color2B2F31
        
        seeAllButton.setTitleColor(Constant.Color.color9CA4AB, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.fontInterRegular(withSize: 13)
    }
    
    private func setupCollectionView() {
        if tvDetailInfo.videos.results.isEmpty {
            heightTrailerView.constant = 0
            seeAllButton.isHidden = true
        } else {
            trailerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            trailerCollectionView.dataSource = self
            trailerCollectionView.delegate = self
            trailerCollectionView.register(UINib(nibName: TrailerCellIdentity, bundle: nil), forCellWithReuseIdentifier: TrailerCellIdentity)
            trailerCollectionView.tag = CollectionViewTag.trailer.rawValue
            seeAllButton.isHidden = false
        }
        
        if tvDetailInfo.images.posters.isEmpty {
            heightImageView.constant = 0
        } else {
            imageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
            imageCollectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
            imageCollectionView.tag = CollectionViewTag.screenshots.rawValue
        }
        
        if tvDetailInfo.credits.cast.isEmpty {
            heightStartingView.constant = 0
        } else {
            startingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            startingCollectionView.dataSource = self
            startingCollectionView.delegate = self
            startingCollectionView.register(UINib(nibName: StartingCellIdentity, bundle: nil), forCellWithReuseIdentifier: StartingCellIdentity)
            startingCollectionView.tag = CollectionViewTag.starting.rawValue
        }
        
        if tvDetailInfo.recommendations.results.isEmpty {
            heightSimilarView.constant = 0
        } else {
            similarCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            similarCollectionView.dataSource = self
            similarCollectionView.delegate = self
            similarCollectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
            similarCollectionView.tag = CollectionViewTag.similarmovies.rawValue
        }
    }
    
    private func bindData() {
        overViewLabel.text = tvDetailInfo.overview
        scrollView.resizeScrollViewContentSize()

    }
    
    @IBAction func didToSeeAll() {
        delegate?.gotoTrailerScreen()
    }
    
}

extension TVGeneralViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            let numberOfItemsTrailer = tvDetailInfo.videos.results.count
            return numberOfItemsTrailer > 5 ? 5 : numberOfItemsTrailer
            
        case .screenshots:
            let numberOfItemsPoster = tvDetailInfo.images.posters.count
            return numberOfItemsPoster > 10 ? 10 : numberOfItemsPoster
            
        case .starting:
            let numberOfItemsActing = tvDetailInfo.credits.cast.count
            return numberOfItemsActing > 10 ? 10 : numberOfItemsActing
            
        case .similarmovies:
            let numberOfItemsSimilar = tvDetailInfo.recommendations.results.count
            return numberOfItemsSimilar > 10 ? 10 : numberOfItemsSimilar
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            return trailerCell(for: collectionView,
                               indexPath: indexPath,
                               videos: tvDetailInfo.videos.results)
            
        case .screenshots:
            let path = tvDetailInfo.images.posters[indexPath.row].file_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        case .starting:
            return startingCell(for: collectionView,
                                indexPath: indexPath,
                                actings: tvDetailInfo.credits.cast)
            
        case .similarmovies:
            let path = tvDetailInfo.recommendations.results[indexPath.row].poster_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    private func trailerCell(for collectionView: UICollectionView,
                             indexPath: IndexPath,
                             videos: [VideoInfo]) -> MovieTrailerCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCellIdentity, for: indexPath) as! MovieTrailerCell
        cell.bindData(videos[indexPath.row])
        return cell
    }
    
    private func imageCell(for collectionView: UICollectionView,
                           indexPath: IndexPath,
                           path: String?) -> ImageCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindData(path)
        return cell
    }
    
    private func startingCell(for collectionView: UICollectionView,
                              indexPath: IndexPath,
                              actings: [CastInfo]) -> StartingCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingCellIdentity, for: indexPath) as! StartingCell
        let acting = tvDetailInfo.credits.cast[indexPath.row]
        cell.bindData(acting)
        return cell
    }
}

extension TVGeneralViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            let key = tvDetailInfo.videos.results[indexPath.row].key
            delegate?.gotoYoutubeScreen(key)
            
        case .screenshots:
            delegate?.gotoScreenShot(indexPath.row)
            
        case .starting:
            let id = tvDetailInfo.credits.cast[indexPath.row].id
            delegate?.gotoActorDetailScreen(id)
            
        case .similarmovies:
            let id = tvDetailInfo.recommendations.results[indexPath.row].id
            delegate?.gotoMovieDetailScreen(id)
            
        default:
            break
        }
    }
}

extension TVGeneralViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            return CGSize(width: 208, height: 117)
            
        case .starting:
            return CGSize(width: 80, height: 76)
            
        case .screenshots, .similarmovies:
            return CGSize(width: 100, height: 150)

        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        
        self.contentSize = contentRect.size
    }
}
