//
//  TVDetailSeasonViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/12.
//

import UIKit

protocol TVDetailSeasonViewControllerDelegate: NSObjectProtocol {
    func showFullEpisode(_ linkInfo: LinkContainerInfo)
    func showSeasonOverView(_ seasonDetailInfo: SeasonDetailInfo)
}

class TVDetailSeasonViewController: BaseViewController<TVDetailSeasonViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let SeasonHorizontalCellIdentity: String = "SeasonHorizontalCell"
    private let EpisodeCellIdentity: String = "EpisodeCell"
    private var selectedSeason: String = .empty
    
    weak var delegate: TVDetailSeasonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        tableView.register(UINib(nibName: SeasonHorizontalCellIdentity, bundle: nil),
                           forCellReuseIdentifier: SeasonHorizontalCellIdentity)
        tableView.register(UINib(nibName: EpisodeCellIdentity, bundle: nil),
                           forCellReuseIdentifier: EpisodeCellIdentity)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TVDetailSeasonViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSection().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = viewModel.getSection()[section]
        
        switch sectionType {
        case .season:
            return 1
            
        case .episcode(let episcodes):
            return episcodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.getSection()[indexPath.section]
        
        switch sectionType {
        case .season(let seasons):
            return seasonHorizontalCell(for: tableView, indexPath: indexPath, seasons: seasons)
            
        case .episcode(let episcodes):
            return episodeCell(for: tableView, indexPath: indexPath, episodes: episcodes)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = viewModel.getSection()[indexPath.section]
        
        switch sectionType {
        case .season:
            return UITableView.automaticDimension
            
        case .episcode:
            return 96
        }
    }
    
    private func seasonHorizontalCell(for tableView: UITableView,
                                      indexPath: IndexPath,
                                      seasons: [SeasonObject]) -> SeasonHorizontalCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeasonHorizontalCellIdentity) as! SeasonHorizontalCell
        cell.delegate = self
        cell.seasons = seasons
        cell.collectionView.reloadData()
        return cell
    }
    
    private func episodeCell(for tableView: UITableView,
                             indexPath: IndexPath,
                             episodes: [EpiscodeInfo]) -> EpisodeCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCellIdentity) as! EpisodeCell
        let episcode = episodes[indexPath.row]
        cell.bindData(episcode)
        return cell
    }
}

extension TVDetailSeasonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = viewModel.getSection()[indexPath.section]
        
        switch sectionType {
        case .episcode(let episcodes):
            if Utils.isShowFull() {
                viewModel.getFullEpisode(selectedSeason,
                                         episode: episcodes[indexPath.row].id) { linkInfo in
                    self.delegate?.showFullEpisode(linkInfo)
                }
            } else {
                self.delegate?.showSeasonOverView(viewModel.getSeasonDetailInfo())
            }
            
        default:
            break
        }
    }
}

extension TVDetailSeasonViewController: SeasonHorizontalCellDelegate {
    func didSelectedSeason(with id: Int, season: String) {
        viewModel.didSelectedCategory(with: id, season: season, completion: {
            self.selectedSeason = season
            self.tableView.reloadData()
        })
    }
}
