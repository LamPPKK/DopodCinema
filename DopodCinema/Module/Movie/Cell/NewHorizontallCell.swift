//
//  NewHorizontallCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

enum ScreenType {
    case movie
    case tv
}

protocol NewHorizontallCellDelegate: NSObjectProtocol {
    func selectedMovie(_ id: Int)
    func selectedTV(_ id: Int)
}

class NewHorizontallCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let NewCellIdentity: String = "NewCell"
    private let startIndexDisplay: Int = 10
    
    weak var delegate: NewHorizontallCellDelegate?
    private var screenType: ScreenType!
    private var movies: [MovieInfo]!
    private var tvShows: [TVShowInfo]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    func bindData(type: ScreenType,
                  movies: [MovieInfo] = [],
                  tvShows: [TVShowInfo] = []) {
        self.screenType = type
        self.movies = movies
        self.tvShows = tvShows
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UINib(nibName: NewCellIdentity, bundle: nil), forCellWithReuseIdentifier: NewCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension NewHorizontallCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch screenType {
        case .movie:
            let numberItemDisplay: Int = movies.count - 5
            return numberItemDisplay > 5 ? 5 : numberItemDisplay
            
        case .tv:
            let numberItemDisplay: Int = tvShows.count - 5
            return numberItemDisplay > 5 ? 5 : numberItemDisplay
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCellIdentity, for: indexPath) as! NewCell
        var posterPath: String?
        
        if screenType == .movie {
            posterPath = movies[indexPath.row + startIndexDisplay].poster_path
        } else {
            posterPath = tvShows[indexPath.row + startIndexDisplay].poster_path
        }
        
        cell.bindData(posterPath)
        return cell
    }
}

extension NewHorizontallCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if screenType == .movie {
            delegate?.selectedMovie(movies[indexPath.row + startIndexDisplay].id)
        } else {
            delegate?.selectedTV(tvShows[indexPath.row + startIndexDisplay].id)
        }
    }
}

extension NewHorizontallCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
