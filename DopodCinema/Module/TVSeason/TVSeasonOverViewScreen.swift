//
//  TVSeasonOverViewScreen.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/29.
//

import UIKit

class TVSeasonOverViewScreen: BaseViewController<TVSeasonOverViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var thePlotLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var startingLabel: UILabel!
    @IBOutlet private weak var startingCollectionView: UICollectionView!
    @IBOutlet private weak var heightStartingView: NSLayoutConstraint!
    
    // MARK: - Property
    private let StartingCellIdentity: String = "StartingCell"
    
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
        
        timeLabel.font = .fontPoppinsRegular(withSize: 13)
        timeLabel.textColor = Constant.Color.color2B2F31
        
        thePlotLabel.font = .fontPoppinsSemiBold(withSize: 16)
        thePlotLabel.textColor = Constant.Color.color2B2F31
        
        overViewLabel.font = .fontPoppinsRegular(withSize: 14)
        overViewLabel.textColor = Constant.Color.color9CA4AB
        
        startingLabel.font = .fontPoppinsSemiBold(withSize: 16)
        startingLabel.textColor = Constant.Color.color2B2F31
    }
    
    private func bindData() {
        setupSubHeader(with: viewModel.getSeasonDetailInfo().name)
        
        if let url =  URL(string: Utils.getPosterPath(viewModel.getSeasonDetailInfo().poster_path, size: .w500)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = viewModel.getSeasonDetailInfo().name
        timeLabel.text = viewModel.getSeasonDetailInfo().air_date?.convertDateToDDMMYYYY()
        overViewLabel.text = viewModel.getSeasonDetailInfo().overview
        
        if viewModel.getSeasonDetailInfo().credits.cast.isEmpty {
            heightStartingView.constant = 0
        } else {
            startingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            startingCollectionView.dataSource = self
            startingCollectionView.delegate = self
            startingCollectionView.register(UINib(nibName: StartingCellIdentity, bundle: nil), forCellWithReuseIdentifier: StartingCellIdentity)
            startingCollectionView.tag = CollectionViewTag.starting.rawValue
            startingCollectionView.reloadData()
        }
    }
}

extension TVSeasonOverViewScreen: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSeasonDetailInfo().credits.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return startingCell(for: collectionView,
                            indexPath: indexPath,
                            actings: viewModel.getSeasonDetailInfo().credits.cast)
    }
    
    private func startingCell(for collectionView: UICollectionView,
                              indexPath: IndexPath,
                              actings: [CastInfo]) -> StartingCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingCellIdentity, for: indexPath) as! StartingCell
        let acting = actings[indexPath.row]
        cell.bindData(acting)
        return cell
    }
}

extension TVSeasonOverViewScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension TVSeasonOverViewScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.getSeasonDetailInfo().credits.cast[indexPath.row].id
        viewModel.showActorDetailInfo(with: id)
    }
}
