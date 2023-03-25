//
//  ComingHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

protocol ComingHorizontalCellDelegate: NSObjectProtocol {
    func selectedMovie(_ id: Int)
    func selectedTV(_ id: Int)
}

class ComingHorizontalCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let ComingCellIdentity: String = "ComingCell"
    
    weak var delegate: ComingHorizontalCellDelegate?
    private var screenType: ScreenType!
    private var movies: [MovieInfo]!
    private var tvShows: [TVShowInfo]!
    private var genres: [GenreInfo]!
    
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
        self.genres = categories
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UINib(nibName: ComingCellIdentity, bundle: nil), forCellWithReuseIdentifier: ComingCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension ComingHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if screenType == .movie {
            return movies.count > 5 ? 5 : movies.count
        } else {
            return tvShows.count > 5 ? 5 : tvShows.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingCellIdentity, for: indexPath) as! ComingCell
        if screenType == .movie {
            let movie = movies[indexPath.row]
            cell.bindData(movie, genres: genres)
        } else {
            let tvShow = tvShows[indexPath.row]
            cell.bindData(tvShow, genres: genres)
        }
        return cell
    }
}

extension ComingHorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if screenType == .movie {
            delegate?.selectedMovie(movies[indexPath.row].id)
        } else {
            delegate?.selectedTV(tvShows[indexPath.row].id)
        }
    }
}

extension ComingHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 328, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

