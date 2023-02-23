//
//  NewHorizontallCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit
import CPCollectionViewWheelLayoutSwift

class NewHorizontallCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let NewCellIdentity: String = "NewCell"
    private let startIndexDisplay: Int = 5
    
    var movies: [MovieInfo]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: NewCellIdentity, bundle: nil), forCellWithReuseIdentifier: NewCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension NewHorizontallCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberItemDisplay: Int = movies.count - 5
        return numberItemDisplay > 5 ? 5 : numberItemDisplay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCellIdentity, for: indexPath) as! NewCell
        let posterPath = movies[indexPath.row + startIndexDisplay].poster_path
        cell.bindData(posterPath)
        return cell
    }
}

extension NewHorizontallCell: UICollectionViewDelegate {
    
}

extension NewHorizontallCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
