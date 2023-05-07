//
//  CategoryViewController+CollectionView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/06.
//

import UIKit

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        if tag == .category {
            return viewModel.getCategories().count
        } else {
            if viewModel.getScreenType() == .movie {
                return viewModel.getMoviesCategory().count
            } else {
                return viewModel.getTVShowsCategory().count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = CollectionViewTag(rawValue: collectionView.tag)

        if tag == .category {
            return categoryCell(for: collectionView, indexPath: indexPath)
        } else {
            return imageCell(for: collectionView, indexPath: indexPath)
        }
    }
    
    private func categoryCell(for collectionView: UICollectionView,
                              indexPath: IndexPath) -> CategoryCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellIdentity, for: indexPath) as! CategoryCell
        cell.bindData(viewModel.getCategories()[indexPath.row])
        return cell
    }
    
    private func imageCell(for collectionView: UICollectionView,
                           indexPath: IndexPath) -> ImageCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        var posterPath: String?
        if viewModel.getScreenType() == .movie {
            posterPath = viewModel.getMoviesCategory()[indexPath.row].poster_path
        } else {
            posterPath = viewModel.getTVShowsCategory()[indexPath.row].poster_path
        }
        
        cell.bindData(posterPath)
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        if tag == .category {
            let id = viewModel.getCategories()[indexPath.row].id
            
            viewModel.didSelectedCategory(with: id) {
                self.categoryCollectionView.reloadData()
                self.categoryCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.collectionView.reloadData()
            }
        } else {
            if viewModel.getScreenType() == .movie {
                let id = viewModel.getMoviesCategory()[indexPath.row].id
                viewModel.showMovieDetailInfo(with: id)
            } else {
                viewModel.gotoTVShowDetail(with: viewModel.getTVShowsCategory()[indexPath.row].id)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMoviesCategory().count - 1 {
            loadingView.isHidden = false
            loadingView.startAnimating()
            loadMore(at: page)
        } else {
            loadingView.isHidden = true
            loadingView.stopAnimating()
        }
    }
    
    private func loadMore(at page: Int) {
        viewModel.getDataMovie(at: page, categoryId: viewModel.idCategory) {
            self.page += 1
            self.collectionView.reloadData()
        }
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        if tag == .category {
            let value: String = viewModel.getCategories()[indexPath.row].name
            let widthOfText: CGFloat = value.widthOfString(usingFont: .fontInterRegular(withSize: 13))
            let widthPerItem: CGFloat = widthOfText + 48
            return CGSize(width: widthPerItem, height: 34)
        } else {
            let paddingSpace: CGFloat = lineSpacing * (itemsPerRow + 1)
            let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
            let widthPerItem: CGFloat = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let tag = CollectionViewTag(rawValue: collectionView.tag)

        if tag == .movies {
            return 12
        } else {
            return 8
        }
    }
}
