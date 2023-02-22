//
//  MovieViewController+TableView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

// MARK: - Extension UITableView
extension MovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSections().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.getSections()[section]
        
        switch section {
        case .popular(let movies):
            return movies.count > 5 ? 5 : movies.count
            
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .top:
            return topHorizontalCellFor(tableView)
            
        case .headerCategory:
            return headerCellFor(tableView, headerTitle: "Category", bottom: 8)

        case .category:
            return categoryHorizontalCell(tableView)
            
        case .headerPopular:
            return headerCellFor(tableView, headerTitle: "Top Popular Movies", bottom: 8)

        case .headerNew:
            return headerCellFor(tableView, headerTitle: "New movies", bottom: 8)

        case .headerComing:
            return headerCellFor(tableView, headerTitle: "Up coming", bottom: 8)

        case .headerActor:
            return headerCellFor(tableView, headerTitle: "Popular people", bottom: 8)

        case .popular(let movies):
            return popularCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .times:
            return timesCellFor(tableView)
            
        case .new:
            return newHorizontallCellFor(tableView)
            
        case .coming(let movies):
            return comingHorizontallCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .actor(let actors):
            return actorHorizontallCell(for: tableView, indexPath: indexPath, actors: actors)
        }
    }
    
    private func topHorizontalCellFor(_ tableView: UITableView) -> TopHorizontalCell {
        let topHorizontallCell = tableView.dequeueReusableCell(withIdentifier: TopHorizontalCellIdentity) as! TopHorizontalCell
        
        return topHorizontallCell
    }
    
    private func headerCellFor(_ tableView: UITableView, headerTitle: String, bottom: CGFloat = 0) -> HeaderCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCellIdentity) as! HeaderCell
        headerCell.setTitle(headerTitle, bottom: bottom)
        return headerCell
    }
    
    private func categoryHorizontalCell(_ tableView: UITableView) -> CategoryHorizontalCell {
        let categoryHorizontalCell = tableView.dequeueReusableCell(withIdentifier: CategoryHorizontalCellIdentity) as! CategoryHorizontalCell
        return categoryHorizontalCell
    }
    
    private func popularCell(for tableView: UITableView,
                             indexPath: IndexPath,
                             movies: [MovieInfo]) -> PopularCell {
        let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCellIdentity) as! PopularCell
        let movie = movies[indexPath.row]
        popularCell.bindData(movie)
        return popularCell
    }
    
    private func timesCellFor(_ tableView: UITableView) -> TimesCell {
        let timesCell = tableView.dequeueReusableCell(withIdentifier: TimesCellIdentity) as! TimesCell
        return timesCell
    }
    
    private func newHorizontallCellFor(_ tableView: UITableView) -> NewHorizontallCell {
        let newHorizontallCell = tableView.dequeueReusableCell(withIdentifier: NewHorizontallCellIdentity) as! NewHorizontallCell
        return newHorizontallCell
    }
    
    private func comingHorizontallCell(for tableView: UITableView,
                                       indexPath: IndexPath,
                                       movies: [MovieInfo]) -> ComingHorizontalCell {
        let comingHorizontalCell = tableView.dequeueReusableCell(withIdentifier: ComingHorizontalCellIdentity) as! ComingHorizontalCell
        comingHorizontalCell.movies = movies
        return comingHorizontalCell
    }
    
    private func actorHorizontallCell(for tableView: UITableView,
                                      indexPath: IndexPath,
                                      actors: [ActorInfo]) -> ActorHorizontallCell {
        let actorHorizontallCell = tableView.dequeueReusableCell(withIdentifier: ActorHorizontallCellIdentity) as! ActorHorizontallCell
        actorHorizontallCell.actors = actors
        return actorHorizontallCell
    }
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .popular:
            return 100
            
        case .times:
            return 156
            
        case .headerCategory, .headerPopular, .headerNew, .headerComing, .headerActor, .category, .new, .coming, .actor, .top:
            return UITableView.automaticDimension
        }
    }
}
