//
//  DiscoverWallpaperViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/17.
//

import UIKit

class DiscoverWallpaperViewController: BaseViewController<DiscoverWallpaperViewModel> {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    init() {
        super.init(nibName: "DiscoverWallpaperViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let DiscoverCheckoutCellIdentity: String = "DiscoverCheckoutCell"
    private let HeaderCellIdentity: String = "HeaderCell"
    private let WallpaperHorizontalCellIdentity: String = "WallpaperHorizontalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel.getAllData {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private functions
    private func setupViews() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: "Wallpaper")
        
        tableView.register(UINib(nibName: DiscoverCheckoutCellIdentity, bundle: nil),
                           forCellReuseIdentifier: DiscoverCheckoutCellIdentity)
        tableView.register(UINib(nibName: HeaderCellIdentity, bundle: nil),
                           forCellReuseIdentifier: HeaderCellIdentity)
        tableView.register(UINib(nibName: WallpaperHorizontalCellIdentity, bundle: nil),
                           forCellReuseIdentifier: WallpaperHorizontalCellIdentity)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DiscoverWallpaperViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSections().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .checkout:
            return checkOutCell(for: tableView)
            
        case .headerMovie:
            return headerCell(for: tableView,
                              headerTitle: "Movie Wallpaper")
            
        case .movies(let wallpapers):
            return wallpaperHorizontalCell(for: tableView,
                                           indexPath: indexPath,
                                           wallpapers: wallpapers)
            
        case .headerActor:
            return headerCell(for: tableView,
                              headerTitle: "Actor Wallpaper")
        case .actors(let wallpapers):
            return wallpaperHorizontalCell(for: tableView,
                                           indexPath: indexPath,
                                           wallpapers: wallpapers)
        }
    }
    
    private func checkOutCell(for tableView: UITableView) -> DiscoverCheckoutCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverCheckoutCellIdentity) as! DiscoverCheckoutCell
        return cell
    }
    
    private func headerCell(for tableView: UITableView,
                            headerTitle: String,
                            bottom: CGFloat = 0) -> HeaderCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCellIdentity) as! HeaderCell
        headerCell.delegate = self
        headerCell.setTitle(headerTitle, bottom: bottom)
        return headerCell
    }
    
    private func wallpaperHorizontalCell(for tableView: UITableView,
                                         indexPath: IndexPath,
                                         wallpapers: [Wallpaper]) -> WallpaperHorizontalCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WallpaperHorizontalCellIdentity) as! WallpaperHorizontalCell
        cell.delegate = self
        cell.bindData(wallpapers)
        return cell
    }
}

extension DiscoverWallpaperViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DiscoverWallpaperViewController: HeaderCellDelegate {
    func didSelectedSeeAllDiscover(section: DiscoverSectionType) {

    }
    
    func didSelectedSeeAllMovie(section: MovieSectionType) {}
    
    func didSelectedSeeAllTV(section: TVSectionType) {}
}

extension DiscoverWallpaperViewController: WallpaperHorizontalCellDelegate {
    func didSelectedWallpaper(_ url: String) {
        viewModel.gotoWallpaperPreview(url)
    }
}
