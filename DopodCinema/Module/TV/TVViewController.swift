//
//  TVViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit
import RxGesture
import RxSwift
import RxCocoa

class TVViewController: BaseViewController<TVViewModel> {

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
    let NewHorizontallCellIdentity: String = "NewHorizontallCell"
    let ComingHorizontalCellIdentity: String = "ComingHorizontalCell"
    let ActorHorizontallCellIdentity: String = "ActorHorizontallCell"
    let DiscoverWallpaperCellIdentity: String = "DiscoverWallpaperCell"
    
    let selectedActorTrigger = PublishSubject<Int>()
    let selectedTVTrigger = PublishSubject<Int>()
    let gotoSearchTrigger = PublishSubject<Void>()
    let gotoDiscoveryTrigger = PublishSubject<Void>()
    let gotoCategoryTrigger = PublishSubject<Void>()
    let selectedCategoryTrigger = PublishSubject<(selectedIndex: Int, categoryID: Int)>()
    let gotoTVListTrigger = PublishSubject<(title: String, type: TVShowType, tvShows: [TVShowInfo])>()
    let gotoActorListTrigger = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindAction()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("show_tabbar"), object: nil)
    }
    
    // MARK: - Private function
    private func setupUI() {
        topConstrait.constant = Constant.HEIGHT_NAV
        setupHeader(withTitle: "TV Show")
        
        searchView.layer.cornerRadius = 16
        searchView.dropShadow(offSet: CGSize(width: 0, height: 4), radius: 16)
        searchLabel.font = .fontInterRegular(withSize: 14)
        searchLabel.textColor = Constant.Color.color97999B
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: TopHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: TopHorizontalCellIdentity)
        tableView.register(UINib(nibName: CategoryHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: CategoryHorizontalCellIdentity)
        tableView.register(UINib(nibName: PopularCellIdentity, bundle: nil), forCellReuseIdentifier: PopularCellIdentity)
        tableView.register(UINib(nibName: HeaderCellIdentity, bundle: nil), forCellReuseIdentifier: HeaderCellIdentity)
        tableView.register(UINib(nibName: NewHorizontallCellIdentity, bundle: nil), forCellReuseIdentifier: NewHorizontallCellIdentity)
        tableView.register(UINib(nibName: ComingHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: ComingHorizontalCellIdentity)
        tableView.register(UINib(nibName: ActorHorizontallCellIdentity, bundle: nil), forCellReuseIdentifier: ActorHorizontallCellIdentity)
        tableView.register(UINib(nibName: DiscoverWallpaperCellIdentity, bundle: nil), forCellReuseIdentifier: DiscoverWallpaperCellIdentity)

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constant.BOTTOM_SAFE_AREA, right: 0)
    }
    
    private func bindAction() {
        searchView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.gotoSearchTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = TVViewModel.Input(selectedActorTrigger: selectedActorTrigger.asObserver(),
                                      selectedTVShowTrigger: selectedTVTrigger.asObserver(),
                                      gotoSearchTrigger: gotoSearchTrigger.asObserver(),
                                      gotoDiscoveryWallPaperTrigger: gotoDiscoveryTrigger.asObserver(),
                                      gotoCategoryTrigger: gotoCategoryTrigger.asObserver(),
                                      selectedCategoryTrigger: selectedCategoryTrigger.asObserver(),
                                      gotoTVListTrigger: gotoTVListTrigger.asObserver(),
                                      gotoActorListTrigger: gotoActorListTrigger.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .drive { isLoading in
                isLoading ? LoadingView.shared.startLoading() : LoadingView.shared.endLoading()
            }
            .disposed(by: disposeBag)
        
        output.errorEvent
            .drive (onNext: {[weak self] error in
                guard let self = self else { return }
                self.showAlert(msg: error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        [output.selectedActorEvent,
         output.selectedTVShowEvent,
         output.gotoSearchEvent,
         output.gotoDiscoveryWallPaperEvent,
         output.gotoCategoryEvent,
         output.selectedCategoryEvent,
         output.gotoTVListEvent,
         output.gotoActorListEvent]
            .forEach({ $0.drive().disposed(by: disposeBag) })
    }
}
