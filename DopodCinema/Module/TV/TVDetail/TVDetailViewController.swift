//
//  TVDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import UIKit
import RxSwift
import RxGesture

class TVDetailViewController: BaseViewController<TVDetailViewModel> {

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
    
    override func didToFavorite() {
        super.didToFavorite()
        
        guard let subHeaderView = self.subHeaderView else {
            return
        }
        
        if subHeaderView.isSave {
            viewModel.save()
        } else {
            viewModel.remove(viewModel.getTVDetailInfo().id)
        }
        
        NotificationCenter.default.post(name: Notification.Name("Did_change_list_favorite"), object: nil)
    }

    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        
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
        setupSubHeader(with: viewModel.getTVDetailInfo().original_name,
                       isDetail: true,
                       isSave: viewModel.isFavourite(viewModel.getTVDetailInfo().id))
        
        if let url = URL(string: Utils.getPosterPath(viewModel.getTVDetailInfo().poster_path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
        
        genresLabel.text = Utils.getGenresString(from: viewModel.getTVDetailInfo().genres, separator: " • ")
        ratingLabel.text = "\(viewModel.getTVDetailInfo().vote_average.format(f: 1))/10"
        nameLabel.text = viewModel.getTVDetailInfo().original_name
        timeLabel.text = "\(viewModel.getTVDetailInfo().number_of_seasons) seasons"
    }
}
