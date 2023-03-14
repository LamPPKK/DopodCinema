//
//  ActorListViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import UIKit

class ActorListViewController: BaseViewController<ActorListViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let ActorCellIdentity: String = "ActorCell"
    private let itemsPerRow: CGFloat = 3
    private let heightPerItem: CGFloat = 175
    private let lineSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: viewModel.getNavigationTitle())
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ActorCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ActorCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ActorListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getActorList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCellIdentity, for: indexPath) as! ActorCell
        let actor = viewModel.getActorList()[indexPath.row]
        cell.bindData(actor)
        return cell
    }
}

extension ActorListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.gotoActorDetail(with: viewModel.getActorList()[indexPath.row].id)
    }
}

extension ActorListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = lineSpacing * (itemsPerRow + 1)
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
