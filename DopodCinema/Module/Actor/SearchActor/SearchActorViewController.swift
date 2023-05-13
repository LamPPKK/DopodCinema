//
//  SearchActorViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/16.
//

import UIKit

protocol SearchActorViewDelegate: NSObjectProtocol {
    func didSelected(id: Int)
}

class SearchActorViewController: BaseViewController<SearchActorViewModel> {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptySearchView: UIView!
    @IBOutlet private weak var emptySearchLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: SearchActorViewDelegate?
    
    private let ActorCellIdentity: String = "ActorCell"
    private let itemsPerRow: CGFloat = 3
    private let heightPerItem: CGFloat = 175
    private let lineSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Did_change_list_search"), object: nil)
        
        setupUI()
        setupCollectionView()
    }

    private func setupUI() {
        emptySearchLabel.font = .fontPoppinsSemiBold(withSize: 16)
        emptySearchLabel.textColor = .black
        
        emptySearchView.isHidden = !viewModel.getActorList().isEmpty
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
        emptySearchView.isHidden = !viewModel.getActorList().isEmpty
        collectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SearchActorViewController: UICollectionViewDataSource {
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

extension SearchActorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(id: viewModel.getActorList()[indexPath.row].id)
    }
}

extension SearchActorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = lineSpacing * (itemsPerRow + 1)
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
