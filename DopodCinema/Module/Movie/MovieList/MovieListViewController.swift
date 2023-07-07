//
//  MovieListViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: BaseViewController<MovieListViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let ComingCellIdentity: String = "ComingCell"
    
    private let loadDataTrigger = PublishRelay<Int>()
    private let loadMoreTrigger = PublishRelay<Int>()
    private let selectedMovieTrigger = PublishRelay<Int>()
    
    private var movies: [MovieInfo] = []
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupUI()
        
        loadDataTrigger.accept(page)
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
        let input = MovieListViewModel.Input(loadDataTrigger: loadDataTrigger.asObservable(),
                                             loadMoreTrigger: loadMoreTrigger.asObservable(),
                                             selectedMovieTrigger: selectedMovieTrigger.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .subscribe(onNext: { isLoading in
                isLoading ? LoadingView.shared.startLoading() : LoadingView.shared.endLoading()
            })
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                if !movies.isEmpty {
                    self.page += 1
                    self.movies.append(contentsOf: movies)
                    self.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        output.errorEvent
            .subscribe { [weak self] error in
                guard let self = self else { return }
                self.showAlert(msg: error.error?.localizedDescription ?? .empty)
            }
            .disposed(by: disposeBag)
        
        output.selectedMovieEvent.subscribe().disposed(by: disposeBag)
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingCellIdentity, for: indexPath) as! ComingCell
        let movie = movies[indexPath.row]
        cell.bindData(movie, genres: viewModel.getCategories())
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovieTrigger.accept(movies[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            loadingView.startAnimating()
            loadingView.isHidden = false
            loadMoreData(at: page)
        } else {
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
    
    private func loadMoreData(at page: Int) {
        loadMoreTrigger.accept(page)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem: CGFloat = collectionView.frame.width - 32
        return CGSize(width: widthPerItem, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
