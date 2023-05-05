//
//  TVListViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import UIKit

class TVListViewController: BaseViewController<TVListViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let ComingCellIdentity: String = "ComingCell"
    private var page: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        setupSubHeader(with: viewModel.getNavigationTitle())
        topConstraint.constant = Constant.HEIGHT_NAV
        
        loadingView.isHidden = true
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ComingCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ComingCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TVListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTVList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingCellIdentity, for: indexPath) as! ComingCell
        let tv = viewModel.getTVList()[indexPath.row]
        cell.bindData(tv, genres: viewModel.getCategories())
        return cell
    }
}

extension TVListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.gotoTVDetail(with: viewModel.getTVList()[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getTVList().count - 1 {
            loadingView.startAnimating()
            loadingView.isHidden = false
            loadMoreData(at: page)
        } else {
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
    
    private func loadMoreData(at page: Int) {
        viewModel.loadMore(at: page) { [weak self] isSucceeded in
            if isSucceeded {
                self?.collectionView.reloadData()
                self?.page += 1
            }
        }
    }
}

extension TVListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem: CGFloat = collectionView.frame.width - 32
        return CGSize(width: widthPerItem, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
