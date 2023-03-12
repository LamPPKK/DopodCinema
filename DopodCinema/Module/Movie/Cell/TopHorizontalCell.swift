//
//  TopHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

import UIKit

@objc
protocol TopHorizontalCellDelegate {
    @objc optional func didSelectMovie(with id: Int)
    @objc optional func didSelectTV(with id: Int)
}

class TopHorizontalCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: CustomPageControl!
    
    // MARK: - Properties
    private let TopCellIdentity: String = "TopCell"
    private var screenType: ScreenType!
    private var movies: [MovieInfo]!
    private var tvShows: [TVShowInfo]!
    private var categories: [GenreInfo]!
    
    weak var delegate: TopHorizontalCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    func bindData(type: ScreenType,
                  movies: [MovieInfo] = [],
                  tvShows: [TVShowInfo] = [],
                  categories: [GenreInfo]) {
        self.screenType = type
        self.movies = movies
        self.tvShows = tvShows
        self.categories = categories
    }
    
    // MARK: - Private functions
    private func setupUI() {
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
extension TopHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCellIdentity, for: indexPath) as! TopCell
        var posterPath: String?
        var category: String = .empty
        var name: String = .empty
        
        if screenType == .movie {
            posterPath = movies[indexPath.row].poster_path
            category = Utils.getFirstNameCategory(from: movies[indexPath.row].genre_ids.first,
                                                  categories: self.categories)
            name = movies[indexPath.row].original_title ?? .empty
        } else {
            posterPath = tvShows[indexPath.row].poster_path
            category = Utils.getFirstNameCategory(from: tvShows[indexPath.row].genre_ids.first,
                                                  categories: self.categories)
            name = tvShows[indexPath.row].name
        }
        
        cell.bindData(posterPath, category: category, name: name)
        return cell
    }
}

extension TopHorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if screenType == .movie {
            delegate?.didSelectMovie?(with: movies[indexPath.row].id)
        } else {
            delegate?.didSelectTV?(with: tvShows[indexPath.row].id)
        }
    }
}

extension TopHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 188, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

