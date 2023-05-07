//
//  ActorDetailViewController+CollectionView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import UIKit

extension ActorDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .movies:
            let numberItemOfMovie = viewModel.actorDetailInfo.movie_credits.cast.count
            return numberItemOfMovie > 10 ? 10 : numberItemOfMovie
            
        case .tvShows:
            let numberItemOfTV = viewModel.actorDetailInfo.tv_credits.cast.count
            return numberItemOfTV > 10 ? 10 : numberItemOfTV
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .movies:
            let path = viewModel.actorDetailInfo.movie_credits.cast[indexPath.row].poster_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        case .tvShows:
            let path = viewModel.actorDetailInfo.tv_credits.cast[indexPath.row].poster_path
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

extension ActorDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .movies, .tvShows:
            return CGSize(width: 136, height: 202)

        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension ActorDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .movies:
            let id = viewModel.actorDetailInfo.movie_credits.cast[indexPath.row].id
            viewModel.showMovieDetailInfo(with: id)
            
        case .tvShows:
            let id = viewModel.actorDetailInfo.tv_credits.cast[indexPath.row].id
            viewModel.showTVDetailInfo(with: id)
            
        default:
            break
        }
    }
}
