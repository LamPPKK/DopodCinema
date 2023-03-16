//
//  MovieViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/07.
//

import UIKit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        viewModel.getAllData {
            self.tableView.reloadData()
        }
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
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constant.BOTTOM_SAFE_AREA, right: 0)
    }
    
    // MARK: - Action
    private func bindAction() {
       searchView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.gotoSearch()
            })
            .disposed(by: disposeBag)
    }
}


