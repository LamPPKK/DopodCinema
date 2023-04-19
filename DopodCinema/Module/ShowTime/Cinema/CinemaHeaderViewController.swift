//
//  CinemaHeaderViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import UIKit

class CinemaHeaderViewController: BaseViewController<CinemaViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    
    // MARK: - Properties
    private let TopCellIdentity: String = "TopCell"
    private let widthPerItem: CGFloat = 232
    private let heightPerItem: CGFloat = 308
    private let lineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        setupSubHeader(with: .empty)
        topConstraint.constant = Constant.HEIGHT_NAV
        
        setupCollectionView()
        
        nameLabel.font = .fontPoppinsSemiBold(withSize: 24)
        nameLabel.textColor = Constant.Color.color2B2F31
        
        categoriesLabel.font = .fontPoppinsRegular(withSize: 13)
        categoriesLabel.textColor = Constant.Color.color2B2F31
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: TopCellIdentity, bundle: nil), forCellWithReuseIdentifier: TopCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let customizeLayout = CustomizeCollectionFlowLayout()
        collectionView.collectionViewLayout = customizeLayout
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let index = Int(self.viewModel.getMoviesCinema().count / 2)
            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
            NotificationCenter.default.post(name: Notification.Name("cinema_reload"), object: index)
            self.setMovieInfo(self.viewModel.getMoviesCinema()[index])
        })
    }
    
    private func setMovieInfo(_ movieInfo: MovieCinema) {
        nameLabel.text = movieInfo.name
        categoriesLabel.text = Utils.getNameGenres(from: movieInfo.categories,
                                                   genres: viewModel.getCategories(),
                                                   separator: " • ")
        setBackdrop(with: movieInfo.posterPath)
    }
    
    private func setBackdrop(with posterPath: String?) {
        if let url = URL(string: Utils.getPosterPath(posterPath)) {
            self.backdropImageView.sd_setImage(with: url,
                                               placeholderImage: UIImage(named: "ic_loading"))
        }
        
        self.backdropImageView.isHidden = true
    }
}

// MARK: - Extension UICollectionView
extension CinemaHeaderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCinema().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCellIdentity, for: indexPath) as! TopCell
        let movie: MovieCinema = viewModel.getMoviesCinema()[indexPath.row]
        
        let category: String = Utils.getFirstNameCategory(from: movie.categories.first,
                                                          categories: viewModel.getCategories())
        
        cell.bindData(movie.posterPath,
                      category: category,
                      name: movie.name ?? .empty)
        return cell
    }
}

extension CinemaHeaderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
            NotificationCenter.default.post(name: Notification.Name("cinema_reload"), object: indexPath.row)
        })
        
        setMovieInfo(viewModel.getMoviesCinema()[indexPath.row])
    }
}

extension CinemaHeaderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
