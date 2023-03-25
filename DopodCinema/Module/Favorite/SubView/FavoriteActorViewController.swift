//
//  FavoriteActorViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import UIKit

protocol FavoriteActorViewDelegate: NSObjectProtocol {
    func didSelected(id: Int)
}

class FavoriteActorViewController: BaseViewController<FavoriteActorViewModel> {
   
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    weak var delegate: FavoriteActorViewDelegate?
    
    private let ActorCellIdentity: String = "ActorCell"
    private let itemsPerRow: CGFloat = 3
    private let heightPerItem: CGFloat = 175
    private let lineSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Did_change_list_favorite"), object: nil)
        
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ActorCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ActorCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc
    private func reloadData() {
        collectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FavoriteActorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListFavorite().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCellIdentity, for: indexPath) as! ActorCell
        let actor = viewModel.getListFavorite()[indexPath.row]
        cell.bindData(actor)
        return cell
    }
}

extension FavoriteActorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(id: viewModel.getListFavorite()[indexPath.row].id)
    }
}

extension FavoriteActorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = lineSpacing * (itemsPerRow + 1)
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
