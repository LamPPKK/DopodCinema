//
//  MovieViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MovieViewController: BaseViewController<MovieViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    let TopHorizontalCellIdentity: String = "TopHorizontalCell"
    let CategoryHorizontalCellIdentity: String = "CategoryHorizontalCell"
    let PopularCellIdentity: String = "PopularCell"
    let HeaderCellIdentity: String = "HeaderCell"
    let TimesCellIdentity: String = "TimesCell"
    let NewHorizontallCellIdentity: String = "NewHorizontallCell"
    let ComingHorizontalCellIdentity: String = "ComingHorizontalCell"
    let ActorHorizontallCellIdentity: String = "ActorHorizontallCell"
    let DiscoverWallpaperCellIdentity: String = "DiscoverWallpaperCell"
    
    let gotoSearchTrigger = PublishRelay<Void>()
    let selectedMovieTrigger = PublishRelay<Int>()
    let selectedActorTrigger = PublishRelay<Int>()
    let seeAllCategoryTrigger = PublishRelay<Void>()
    let selectedCategoryTrigger = PublishRelay<(selectedIndex: Int, idCategory: Int)>()
    let gotoMovieListTrigger = PublishRelay<(title: String, type: MovieType)>()
    let gotoActorListTrigger = PublishRelay<String>()
    let gotoWallpaperTrigger = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("show_tabbar"), object: nil)
    }
    
    // MARK: - Private function
    private func setupUI() {
        topConstrait.constant = Constant.HEIGHT_NAV
        setupHeader(withTitle: "Movie")
        
        searchView.layer.cornerRadius = 16
        searchView.dropShadow(offSet: CGSize(width: 0, height: 4), radius: 16)
        searchLabel.font = .fontInterRegular(withSize: 14)
        searchLabel.textColor = Constant.Color.color97999B
        
        setupTableView()
        
        bindAction()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: TopHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: TopHorizontalCellIdentity)
        tableView.register(UINib(nibName: CategoryHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: CategoryHorizontalCellIdentity)
        tableView.register(UINib(nibName: PopularCellIdentity, bundle: nil), forCellReuseIdentifier: PopularCellIdentity)
        tableView.register(UINib(nibName: HeaderCellIdentity, bundle: nil), forCellReuseIdentifier: HeaderCellIdentity)
        tableView.register(UINib(nibName: TimesCellIdentity, bundle: nil), forCellReuseIdentifier: TimesCellIdentity)
        tableView.register(UINib(nibName: NewHorizontallCellIdentity, bundle: nil), forCellReuseIdentifier: NewHorizontallCellIdentity)
        tableView.register(UINib(nibName: ComingHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: ComingHorizontalCellIdentity)
        tableView.register(UINib(nibName: ActorHorizontallCellIdentity, bundle: nil), forCellReuseIdentifier: ActorHorizontallCellIdentity)
        tableView.register(UINib(nibName: DiscoverWallpaperCellIdentity, bundle: nil), forCellReuseIdentifier: DiscoverWallpaperCellIdentity)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constant.BOTTOM_SAFE_AREA, right: 0)
    }
    
    private func bindViewModel() {
        let input = MovieViewModel.Input(gotoSearchTrigger: gotoSearchTrigger.asObservable(),
                                         selectedMovieTrigger: selectedMovieTrigger.asObservable(),
                                         selectedActorTrigger: selectedActorTrigger.asObservable(),
                                         seeAllCategoryTrigger: seeAllCategoryTrigger.asObservable(),
                                         selectedCategoryTrigger: selectedCategoryTrigger.asObservable(),
                                         gotoMovieListTrigger: gotoMovieListTrigger.asObservable(),
                                         gotoActorListTrigger: gotoActorListTrigger.asObservable(),
                                         gotoDiscoveryWallPaperTrigger: gotoWallpaperTrigger.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .subscribe(onNext: { isLoading in
                isLoading ? LoadingView.shared.startLoading() : LoadingView.shared.endLoading()
            })
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.gotoSearchEvent.subscribe().disposed(by: disposeBag)
        output.selectedMovieEvent.subscribe().disposed(by: disposeBag)
        output.selectedActorEvent.subscribe().disposed(by: disposeBag)
        output.seeAllCategoryEvent.subscribe().disposed(by: disposeBag)
        output.selectedCategoryEvent.subscribe().disposed(by: disposeBag)
        output.gotoMovieListEvent.subscribe().disposed(by: disposeBag)
        output.gotoActorListEvent.subscribe().disposed(by: disposeBag)
        output.gotoDiscoveryWallPaperEvent.subscribe().disposed(by: disposeBag)
    }
    
    // MARK: - Action
    private func bindAction() {
       searchView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.gotoSearchTrigger.accept(())
            })
            .disposed(by: disposeBag)
    }
}


