//
//  TVListViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import UIKit
import RxSwift
import RxCocoa

class TVListViewController: BaseViewController<TVListViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let ComingCellIdentity: String = "ComingCell"
    private let loadDataTrigger = PublishSubject<Int>()
    private let loadMoreTrigger = PublishSubject<Int>()
    private let selectedTVDetailTrigger = PublishSubject<Int>()
    private var tvShows = [TVShowInfo]()
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        
        loadDataTrigger.onNext(page)
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
    
    private func bindViewModel() {
        let input = TVListViewModel.Input(loadDataTrigger: loadDataTrigger.asObserver(),
                                          loadMoreTrigger: loadMoreTrigger.asObserver(),
                                          selectedTVDetailTrigger: selectedTVDetailTrigger.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .drive { isLoading in
                isLoading ? LoadingView.shared.startLoading() : LoadingView.shared.endLoading()
            }
            .disposed(by: disposeBag)
        
        output.errorEvent
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(msg: error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .drive(onNext: { [weak self] tvShows in
                guard let self = self else { return }
                if !tvShows.isEmpty {
                    self.page += 1
                    self.tvShows.append(contentsOf: tvShows)
                    self.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        output.selectedTVDetailEvent.drive().disposed(by: disposeBag)
    }
}

extension TVListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingCellIdentity, for: indexPath) as! ComingCell
        let tv = tvShows[indexPath.row]
        cell.bindData(tv, genres: viewModel.getCategories())
        return cell
    }
}

extension TVListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTVDetailTrigger.onNext(tvShows[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == tvShows.count - 1 {
            loadingView.startAnimating()
            loadingView.isHidden = false
            loadMoreData(at: page)
        } else {
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
    
    private func loadMoreData(at page: Int) {
        loadMoreTrigger.onNext(page)
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
