//
//  FavoriteDataViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

protocol FavoriteDataViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
}

class FavoriteDataViewController: BaseViewController<FavoriteDataViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let ImageCellIdentity: String = "ImageCell"
    private let itemsPerRow: CGFloat = 3
    private let lineSpacing: CGFloat = 5
    private let heightPerItem: CGFloat = 165
    
    weak var delegate: FavoriteDataViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Did_change_list_favorite"), object: nil)
        
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ImageCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc
    private func reloadData() {
        collectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FavoriteDataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListFavorite().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindData(viewModel.getListFavorite()[indexPath.row].path)
        return cell
    }
}

extension FavoriteDataViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = viewModel.getListFavorite()[indexPath.row]
        delegate?.didSelectedObject(id: object.id, isMovie: viewModel.isMovie())
    }
}

extension FavoriteDataViewController: UICollectionViewDelegateFlowLayout {
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
