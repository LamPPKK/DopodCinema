//
//  SearchDataViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import UIKit

protocol SearchDataViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
}

class SearchDataViewController: BaseViewController<SearchDataViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let ImageCellIdentity: String = "ImageCell"
    private let itemsPerRow: CGFloat = 3
    private let lineSpacing: CGFloat = 5
    private let heightPerItem: CGFloat = 165
    
    weak var delegate: SearchDataViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ImageCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SearchDataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSearchObjects().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindData(viewModel.getSearchObjects()[indexPath.row].posterPath)
        return cell
    }
}

extension SearchDataViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = viewModel.getSearchObjects()[indexPath.row]
        delegate?.didSelectedObject(id: object.id, isMovie: object.isMovieObject)
    }
}

extension SearchDataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = (lineSpacing * (itemsPerRow - 1)) + 32
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}