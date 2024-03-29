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
            
        case .discoverWallpaper:
            return discoverWallPaperCell(for: tableView)
            
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
        headerCell.delegate = self
        headerCell.setTitle(headerTitle, bottom: bottom, tvSection: type)
        return headerCell
    }
    
    private func categoryHorizontalCell(for tableView: UITableView,
                                        indexPath: IndexPath,
                                        categories: [GenreInfo]) -> CategoryHorizontalCell {
        let categoryHorizontalCell = tableView.dequeueReusableCell(withIdentifier: CategoryHorizontalCellIdentity) as! CategoryHorizontalCell
        categoryHorizontalCell.delegate = self
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
    
    private func discoverWallPaperCell(for tableView: UITableView) -> DiscoverWallpaperCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverWallpaperCellIdentity) as! DiscoverWallpaperCell
        return cell
    }
}

extension TVViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .top,
                .headerCategory,
                .category,
                .headerPopular,
                .headerOnAir,
                .onAir,
                .headerToprate,
                .toprate,
                .headerActor,
                .actor,
                .discoverWallpaper:
            return UITableView.automaticDimension
            
        case .popular:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .popular(let tvShows):
            selectedTVTrigger.onNext(tvShows[indexPath.row].id)
            
        case .discoverWallpaper:
            gotoDiscoveryTrigger.onNext(())
            
        default:
            break
        }
    }
}

extension TVViewController: HeaderCellDelegate {
    func didSelectedSeeAllMovie(section: MovieSectionType) {}
    
    func didSelectedSeeAllDiscover(section: DiscoverSectionType) {}
    
    func didSelectedSeeAllTV(section: TVSectionType) {
        switch section {
        case .headerCategory:
            gotoCategoryTrigger.onNext(())
            
        case .headerPopular(let title):
            gotoTVListTrigger.onNext((title: title,
                                      type: .popular,
                                      tvShows: viewModel.getPopularList()))

        case .headerOnAir(let title):
            gotoTVListTrigger.onNext((title: title,
                                      type: .onAir,
                                      tvShows: viewModel.getOnAirList()))
            
        case .headerToprate(let title):
            gotoTVListTrigger.onNext((title: title,
                                      type: .topRate,
                                      tvShows: viewModel.getToprateList()))
            
        case .headerActor(let title):
            gotoActorListTrigger.onNext(title)
            
        default:
            break
        }
    }
}

extension TVViewController: TopHorizontalCellDelegate {
    func didSelectTV(with id: Int) {
        selectedTVTrigger.onNext(id)
    }
}

extension TVViewController: NewHorizontallCellDelegate, ComingHorizontalCellDelegate {
    func selectedMovie(_ id: Int) {}
    
    func selectedTV(_ id: Int) {
        selectedTVTrigger.onNext(id)
    }
}

extension TVViewController: ActorHorizontallCellDelegate {
    func didSelectedActor(id: Int) {
        selectedActorTrigger.onNext(id)
    }
}

extension TVViewController: CategoryHorizontalCellDelgate {
    func selectedCategory(selectedIndex: Int, id: Int) {
        selectedCategoryTrigger.onNext((selectedIndex, id))
    }
}
