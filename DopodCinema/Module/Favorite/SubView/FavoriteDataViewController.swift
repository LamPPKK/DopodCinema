//
//  FavoriteDataViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

protocol FavoriteDataViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
    func removeObject(type: SearchPagerTag, selectedObject: SavedInfo)
}

class FavoriteDataViewController: BaseViewController<FavoriteDataViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    // MARK: - Properties
    private let ImageCellIdentity: String = "ImageCell"
    private let itemsPerRow: CGFloat = 3
    private let lineSpacing: CGFloat = 5
    private var heightPerItem: CGFloat = 165
    
    weak var delegate: FavoriteDataViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Did_change_list_favorite"), object: nil)
        
        emptyLabel.font = .fontPoppinsSemiBold(withSize: 16)
        emptyView.isHidden = !viewModel.getListFavorite().isEmpty
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ImageCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressToItem(gesture:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc
    private func reloadData() {
        emptyView.isHidden = !viewModel.getListFavorite().isEmpty
        collectionView.reloadData()
    }
    
    @objc
    private func longPressToItem(gesture: UILongPressGestureRecognizer) {
        if (gesture.state != .began) {
            return
        }

        let point = gesture.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: point) {
            let object = viewModel.getListFavorite()[indexPath.row]
            delegate?.removeObject(type: viewModel.isMovie() ? .kMovie : .kTV,
                                   selectedObject: object)
        }
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            heightPerItem = widthPerItem / 0.75
        }
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}

extension FavoriteDataViewController: UIGestureRecognizerDelegate {
    
}
