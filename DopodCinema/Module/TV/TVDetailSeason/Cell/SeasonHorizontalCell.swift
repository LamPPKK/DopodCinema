//
//  SeasonHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/12.
//

import UIKit

protocol SeasonHorizontalCellDelegate: NSObjectProtocol {
    func didSelectedSeason(with id: Int, season: String)
}

class SeasonHorizontalCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let SeasonCellIdentity: String = "SeasonCell"
    weak var delegate: SeasonHorizontalCellDelegate?
    
    var seasons: [SeasonObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UINib(nibName: SeasonCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: SeasonCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SeasonHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return seasonCell(for: collectionView, indexPath: indexPath)
    }
    
    private func seasonCell(for collectionView: UICollectionView,
                            indexPath: IndexPath) -> SeasonCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCellIdentity, for: indexPath) as! SeasonCell
        let season = seasons[indexPath.row]
        cell.bindData(season)
        return cell
    }
}

extension SeasonHorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedSeason(with: seasons[indexPath.row].id,
                                    season: seasons[indexPath.row].name)
    }
}

extension SeasonHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 184)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
