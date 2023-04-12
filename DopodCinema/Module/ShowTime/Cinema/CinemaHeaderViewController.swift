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
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: TopCellIdentity, bundle: nil), forCellWithReuseIdentifier: TopCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let customizeLayout = CustomizeCollectionFlowLayout()
        collectionView.collectionViewLayout = customizeLayout
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.collectionView.scrollToItem(at: IndexPath(row: 2, section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        })
    }
}

// MARK: - Extension UICollectionView
extension CinemaHeaderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCinema().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCellIdentity, for: indexPath) as! TopCell
        var category: String = .empty
        let movie: MovieCinema = viewModel.getMoviesCinema()[indexPath.row]
        
        cell.bindData(movie.posterPath,
                      category: category,
                      name: movie.name ?? .empty)
        return cell
    }
}

extension CinemaHeaderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
