//
//  ActorDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import UIKit

class ActorDetailViewController: BaseViewController<ActorDetailViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dobTitle: UILabel!
    @IBOutlet private weak var dobLabel: UILabel!
    @IBOutlet private weak var dopTitle: UILabel!
    @IBOutlet private weak var dopLabel: UILabel!
    @IBOutlet private weak var thePlotLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var moviesLabel: UILabel!
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    @IBOutlet private weak var tvLabel: UILabel!
    @IBOutlet private weak var tvCollectionView: UICollectionView!
    
    // MARK: - Properties
    let ImageCellIdentity: String = "ImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        bindData()
    }
    
    override func didToFavorite() {
        super.didToFavorite()
        
        guard let subHeaderView = self.subHeaderView else {
            return
        }
        
        if subHeaderView.isSave {
            viewModel.save()
        } else {
            viewModel.remove()
        }
        
        NotificationCenter.default.post(name: Notification.Name("Did_change_list_favorite"), object: nil)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: .empty,
                       isDetail: true)
        
        profileImageView.corner(radius: 8)
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .fontPoppinsSemiBold(withSize: 24)
        nameLabel.textColor = Constant.Color.color2B2F31
        
        dobTitle.font = .fontPoppinsSemiBold(withSize: 14)
        dobTitle.textColor = Constant.Color.color2B2F31
        
        dobLabel.font = .fontPoppinsRegular(withSize: 14)
        dobLabel.textColor = Constant.Color.color2B2F31
        
        dopTitle.font = .fontPoppinsSemiBold(withSize: 14)
        dopTitle.textColor = Constant.Color.color2B2F31
        
        dopLabel.font = .fontPoppinsRegular(withSize: 14)
        dopLabel.textColor = Constant.Color.color2B2F31
        
        thePlotLabel.font = .fontPoppinsSemiBold(withSize: 16)
        thePlotLabel.textColor = Constant.Color.color2B2F31
        
        overViewLabel.font = .fontPoppinsRegular(withSize: 14)
        overViewLabel.textColor = Constant.Color.color9CA4AB
        
        moviesLabel.font = .fontPoppinsSemiBold(withSize: 16)
        moviesLabel.textColor = Constant.Color.color2B2F31
        
        tvLabel.font = .fontPoppinsSemiBold(withSize: 16)
        tvLabel.textColor = Constant.Color.color2B2F31
    }
    
    private func setupCollectionView() {
        movieCollectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.tag = CollectionViewTag.movies.rawValue
        movieCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func bindData() {
        let actorDetailInfo = viewModel.actorDetailInfo
        
        if let url = URL(string: Utils.getPosterPath(actorDetailInfo.profile_path, size: .w342)) {
            profileImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            profileImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = actorDetailInfo.name
        dobLabel.text = actorDetailInfo.birthday?.convertDateToMMMMDDYYYY()
        dopLabel.text = actorDetailInfo.place_of_birth
        overViewLabel.text = actorDetailInfo.biography
    }
}
