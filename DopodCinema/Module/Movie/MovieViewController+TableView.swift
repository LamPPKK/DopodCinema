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
        case .popular:
            return 5
            
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSections()[indexPath.section]
        
        switch section {
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

        case .popular:
            return popularCellFor(tableView)
            
        case .times:
            return timesCellFor(tableView)
            
        case .new:
            return newHorizontallCellFor(tableView)
            
        case .coming:
            return comingHorizontallCellFor(tableView)
            
        case .actor:
            return actorHorizontallCellFor(tableView)
            
        default:
            return UITableViewCell()
        }
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
    
    private func popularCellFor(_ tableView: UITableView) -> PopularCell {
        let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCellIdentity) as! PopularCell
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
    
    private func comingHorizontallCellFor(_ tableView: UITableView) -> ComingHorizontalCell {
        let comingHorizontalCell = tableView.dequeueReusableCell(withIdentifier: ComingHorizontalCellIdentity) as! ComingHorizontalCell
        return comingHorizontalCell
    }
    
    private func actorHorizontallCellFor(_ tableView: UITableView) -> ActorHorizontallCell {
        let actorHorizontallCell = tableView.dequeueReusableCell(withIdentifier: ActorHorizontallCellIdentity) as! ActorHorizontallCell
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
            
        case .headerCategory, .headerPopular, .headerNew, .headerComing, .headerActor, .category, .new, .coming, .actor:
            return UITableView.automaticDimension
            
        default:
            return 0
        }
        
    }
}
