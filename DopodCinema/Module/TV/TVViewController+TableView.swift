//
//  TVViewController+TableView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

// MARK: - Extension UITableView
extension TVViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSections().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.getSections()[section]
        
        switch section {
        case .popular:
            return 5
            
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .top(let tvshows):
            return topHorizontalCell(for: tableView,
                                     indexPath: indexPath,
                                     tvShows: tvshows)
            
        case .headerCategory(let title):
            return headerCell(for: tableView, headerTitle: title, type: section)

        case .category(let categories):
            return categoryHorizontalCell(for: tableView,
                                          indexPath: indexPath,
                                          categories: categories)
            
        case .headerPopular(let title):
            return headerCell(for: tableView, headerTitle: title, type: section)

        case .popular(let tvShows):
            return popularCell(for: tableView,
                               indexPath: indexPath,
                               tvShows: tvShows)
            
        case .headerOnAir(let title):
            return headerCell(for: tableView, headerTitle: title, type: section)
            
        case .onAir(let tvShows):
            return newHorizontallCell(for: tableView,
                                      indexPath: indexPath,
                                      tvShows: tvShows)
            
        case .headerToprate(let title):
            return headerCell(for: tableView, headerTitle: title, type: section)
            
        case .toprate(let tvShows):
            return comingHorizontallCell(for: tableView,
                                         indexPath: indexPath,
                                         tvShows: tvShows)
            
        case .headerActor(let title):
            return headerCell(for: tableView, headerTitle: title, type: section)

        case .actor(let actors):
            return actorHorizontallCell(for: tableView,
                                        indexPath: indexPath,
                                        actors: actors)
        }
    }
    
    private func topHorizontalCell(for tableView: UITableView,
                                      indexPath: IndexPath,
                                      tvShows: [TVShowInfo]) -> TopHorizontalCell {
        let topHorizontallCell = tableView.dequeueReusableCell(withIdentifier: TopHorizontalCellIdentity) as! TopHorizontalCell
        topHorizontallCell.delegate = self
        topHorizontallCell.bindData(type: .tv,
                                    tvShows: tvShows,
                                    categories: viewModel.getCategories())
        return topHorizontallCell
    }
    
    private func headerCell(for tableView: UITableView,
                            headerTitle: String,
                            bottom: CGFloat = 0,
                            type: TVSectionType) -> HeaderCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCellIdentity) as! HeaderCell
        headerCell.setTitle(headerTitle, bottom: bottom, tvSection: type)
        return headerCell
    }
    
    private func categoryHorizontalCell(for tableView: UITableView,
                                        indexPath: IndexPath,
                                        categories: [GenreInfo]) -> CategoryHorizontalCell {
        let categoryHorizontalCell = tableView.dequeueReusableCell(withIdentifier: CategoryHorizontalCellIdentity) as! CategoryHorizontalCell
        categoryHorizontalCell.categories = categories
        return categoryHorizontalCell
    }
    
    private func popularCell(for tableView: UITableView,
                             indexPath: IndexPath,
                             tvShows: [TVShowInfo]) -> PopularCell {
        let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCellIdentity) as! PopularCell
        let tvShow = tvShows[indexPath.row]
        popularCell.bindData(tvShow, genres: viewModel.getCategories())
        return popularCell
    }
    
    private func newHorizontallCell(for tableView: UITableView,
                                    indexPath: IndexPath,
                                    tvShows: [TVShowInfo]) -> NewHorizontallCell {
        let newHorizontallCell = tableView.dequeueReusableCell(withIdentifier: NewHorizontallCellIdentity) as! NewHorizontallCell
        newHorizontallCell.delegate = self
        newHorizontallCell.bindData(type: .tv, tvShows: tvShows)
        return newHorizontallCell
    }
    
    private func comingHorizontallCell(for tableView: UITableView,
                                       indexPath: IndexPath,
                                       tvShows: [TVShowInfo]) -> ComingHorizontalCell {
        let comingHorizontalCell = tableView.dequeueReusableCell(withIdentifier: ComingHorizontalCellIdentity) as! ComingHorizontalCell
        comingHorizontalCell.delegate = self
        comingHorizontalCell.bindData(type: .tv, tvShows: tvShows, categories: viewModel.getCategories())
        return comingHorizontalCell
    }
    
    private func actorHorizontallCell(for tableView: UITableView,
                                      indexPath: IndexPath,
                                      actors: [ActorInfo]) -> ActorHorizontallCell {
        let actorHorizontallCell = tableView.dequeueReusableCell(withIdentifier: ActorHorizontallCellIdentity) as! ActorHorizontallCell
        actorHorizontallCell.delegate = self
        actorHorizontallCell.actors = actors
        return actorHorizontallCell
    }
}

extension TVViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .top, .headerCategory, .category, .headerOnAir, .onAir, .headerToprate, .toprate, .headerActor, .actor:
            return UITableView.automaticDimension
            
        case .popular:
            return 100
            
        default:
            return 0
        }
    }
}

extension TVViewController: TopHorizontalCellDelegate {
    func didSelectTV(with id: Int) {
        viewModel.showTVDetail(with: id)
    }
}

extension TVViewController: NewHorizontallCellDelegate, ComingHorizontalCellDelegate {
    func selectedMovie(_ id: Int) {
        
    }
}

extension TVViewController: ActorHorizontallCellDelegate {
    func didSelectedActor(id: Int) {
        viewModel.showActorDetail(with: id)
    }
}
