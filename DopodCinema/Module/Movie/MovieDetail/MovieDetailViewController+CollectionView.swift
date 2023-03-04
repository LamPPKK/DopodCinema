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
        case .trailer:
            let numberOfItemsTrailer = viewModel.movieDetailInfo.videos.results.count
            return numberOfItemsTrailer > 5 ? 5 : numberOfItemsTrailer
            
        case .screenshots:
            let numberOfItemsPoster = viewModel.movieDetailInfo.images.posters.count
            return numberOfItemsPoster > 10 ? 10 : numberOfItemsPoster
            
        case .starting:
            let numberOfItemsActing = viewModel.movieDetailInfo.credits.cast.count
            return numberOfItemsActing > 10 ? 10 : numberOfItemsActing
            
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
        case .trailer:
            return trailerCell(for: collectionView, indexPath: indexPath, videos: viewModel.movieDetailInfo.videos.results)
            
        case .screenshots:
            let path = viewModel.movieDetailInfo.images.posters[indexPath.row].file_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        case .starting:
            return startingCell(for: collectionView,
                                indexPath: indexPath,
                                actings: viewModel.movieDetailInfo.credits.cast)
            
        case .similarmovies:
            let path = viewModel.movieDetailInfo.recommendations.results[indexPath.row].poster_path
            return imageCell(for: collectionView, indexPath: indexPath, path: path)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    private func trailerCell(for collectionView: UICollectionView,
                             indexPath: IndexPath,
                             videos: [VideoInfo]) -> TrailerCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCellIdentity, for: indexPath) as! TrailerCell
        cell.bindData(videos[indexPath.row])
        return cell
    }
    
    private func imageCell(for collectionView: UICollectionView,
                           indexPath: IndexPath,
                           path: String?) -> ImageCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindData(path)
        return cell
    }
    
    private func startingCell(for collectionView: UICollectionView,
                              indexPath: IndexPath,
                              actings: [CastInfo]) -> StartingCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingCellIdentity, for: indexPath) as! StartingCell
        let acting = viewModel.movieDetailInfo.credits.cast[indexPath.row]
        cell.bindData(acting)
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            return CGSize(width: 208, height: 117)
            
        case .starting:
            return CGSize(width: 80, height: 76)
            
        case .screenshots, .similarmovies:
            return CGSize(width: 100, height: 150)

        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .trailer:
            break
            
        case .screenshots:
            break
            
        case .starting:
            break
            
        case .similarmovies:
            let id = viewModel.movieDetailInfo.recommendations.results[indexPath.row].id
            viewModel.showMovieDetail(with: id)
            
        case .none:
            break
        }
    }
}
