//
//  MovieDetailViewController+CollectionView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/26.
//

import UIKit

extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .screenshots:
            let numberOfItemsPoster = viewModel.movieDetailInfo.images.posters.count
            return numberOfItemsPoster > 10 ? 10 : numberOfItemsPoster
            
        case .similarmovies:
            let numberOfItemsSimilar = viewModel.movieDetailInfo.recommendations.results.count
            return numberOfItemsSimilar > 10 ? 10 : numberOfItemsSimilar
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .screenshots:
            let path = viewModel.movieDetailInfo.images.posters[indexPath.row].file_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        case .similarmovies:
            let path = viewModel.movieDetailInfo.recommendations.results[indexPath.row].poster_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    private func imageCell(for collectionView: UICollectionView,
                           indexPath: IndexPath,
                           path: String?) -> ImageCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindData(path)
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
