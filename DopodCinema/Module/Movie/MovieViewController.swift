//
//  MovieViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/07.
//

import UIKit
import RxRelay

class MovieViewController: BaseViewController<MovieViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    let CategoryHorizontalCellIdentity: String = "CategoryHorizontalCell"
    let PopularCellIdentity: String = "PopularCell"
    let HeaderCellIdentity: String = "HeaderCell"
    let TimesCellIdentity: String = "TimesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private function
    private func setupUI() {
        topConstrait.constant = Constant.HEIGHT_NAV
        setupHeader(withTitle: "Movie")
        
        searchView.layer.cornerRadius = 16
        searchView.dropShadow(offSet: CGSize(width: 1, height: 1), radius: 8)
        searchLabel.font = UIFont.fontInterRegular(withSize: 14)
        searchLabel.textColor = Constant.Color.color97999B
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CategoryHorizontalCellIdentity, bundle: nil), forCellReuseIdentifier: CategoryHorizontalCellIdentity)
        tableView.register(UINib(nibName: PopularCellIdentity, bundle: nil), forCellReuseIdentifier: PopularCellIdentity)
        tableView.register(UINib(nibName: HeaderCellIdentity, bundle: nil), forCellReuseIdentifier: HeaderCellIdentity)
        tableView.register(UINib(nibName: TimesCellIdentity, bundle: nil), forCellReuseIdentifier: TimesCellIdentity)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constant.BOTTOM_SAFE_AREA, right: 0)
    }
}


