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
        case .top(let movies):
            return topHorizontalCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .headerCategory(let title):
            return headerCell(for: tableView, headerTitle: title, bottom: 8)

        case .category(let categories):
            return categoryHorizontalCell(for: tableView, indexPath: indexPath, categories: categories)
            
        case .headerPopular(let title):
            return headerCell(for: tableView, headerTitle: title, bottom: 8)

        case .popular(let movies):
            return popularCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .times:
            return timesCellFor(tableView)
            
        case .headerNew(let title):
            return headerCell(for: tableView, headerTitle: title, bottom: 8)

        case .new(let movies):
            return newHorizontallCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .headerComing(let title):
            return headerCell(for: tableView, headerTitle: title, bottom: 8)

        case .coming(let movies):
            return comingHorizontallCell(for: tableView, indexPath: indexPath, movies: movies)
            
        case .headerActor(let title):
            return headerCell(for: tableView, headerTitle: title, bottom: 8)
            
        case .actor(let actors):
            return actorHorizontallCell(for: tableView, indexPath: indexPath, actors: actors)
        }
    }
    
    private func topHorizontalCell(for tableView: UITableView,
                                      indexPath: IndexPath,
                                      movies: [MovieInfo]) -> TopHorizontalCell {
        let topHorizontallCell = tableView.dequeueReusableCell(withIdentifier: TopHorizontalCellIdentity) as! TopHorizontalCell
        topHorizontallCell.movies = movies
        return topHorizontallCell
    }
    
    private func headerCell(for tableView: UITableView,
                            headerTitle: String,
                            bottom: CGFloat = 0) -> HeaderCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCellIdentity) as! HeaderCell
        headerCell.setTitle(headerTitle, bottom: bottom)
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
                             movies: [MovieInfo]) -> PopularCell {
        let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCellIdentity) as! PopularCell
        let movie = movies[indexPath.row]
        popularCell.bindData(movie, genres: viewModel.categories)
        return popularCell
    }
    
    private func timesCellFor(_ tableView: UITableView) -> TimesCell {
        let timesCell = tableView.dequeueReusableCell(withIdentifier: TimesCellIdentity) as! TimesCell
        return timesCell
    }
    
    private func newHorizontallCell(for tableView: UITableView,
                                    indexPath: IndexPath,
                                    movies: [MovieInfo]) -> NewHorizontallCell {
        let newHorizontallCell = tableView.dequeueReusableCell(withIdentifier: NewHorizontallCellIdentity) as! NewHorizontallCell
        newHorizontallCell.delegate = self
        newHorizontallCell.movies = movies
        return newHorizontallCell
    }
    
    private func comingHorizontallCell(for tableView: UITableView,
                                       indexPath: IndexPath,
                                       movies: [MovieInfo]) -> ComingHorizontalCell {
        let comingHorizontalCell = tableView.dequeueReusableCell(withIdentifier: ComingHorizontalCellIdentity) as! ComingHorizontalCell
        comingHorizontalCell.delegate = self
        comingHorizontalCell.movies = movies
        comingHorizontalCell.genres = viewModel.categories
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
        case .popular(let movies):
            let id = movies[indexPath.row].id
            viewModel.showMovieDetailInfo(with: id)
            
        default:
            break
        }
    }
}

extension MovieViewController: NewHorizontallCellDelegate, ComingHorizontalCellDelegate {
    func selectedMovie(_ id: Int) {
        viewModel.showMovieDetailInfo(with: id)
    }
}

extension MovieViewController: ActorHorizontallCellDelegate {
    func didSelectedActor(id: Int) {
        viewModel.showActorDetail(with: id)
    }
}
