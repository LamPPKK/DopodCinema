//
//  TopHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

import UIKit

class TopHorizontalCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let TopCellIdentity: String = "TopCell"
    var movies: [MovieInfo]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: TopCellIdentity, bundle: nil), forCellWithReuseIdentifier: TopCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension TopHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCellIdentity, for: indexPath) as! TopCell
        let posterPath = movies[indexPath.row].poster_path
        cell.bindData(posterPath)
        return cell
    }
}

extension TopHorizontalCell: UICollectionViewDelegate {
    
}

extension TopHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 188, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

