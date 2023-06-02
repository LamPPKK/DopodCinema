//
//  ActorHorizontallCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

protocol ActorHorizontallCellDelegate: NSObjectProtocol {
    func didSelectedActor(id: Int)
}

class ActorHorizontallCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let ActorCellIdentity: String = "ActorCell"
    weak var delegate: ActorHorizontallCellDelegate?
    
    var actors: [ActorInfo]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UINib(nibName: ActorCellIdentity, bundle: nil), forCellWithReuseIdentifier: ActorCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

// MARK: - Extension UICollectionView
extension ActorHorizontallCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count > 15 ? 15 : actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCellIdentity, for: indexPath) as! ActorCell
        let actor = actors[indexPath.row]
        cell.bindData(actor)
        return cell
    }
}

extension ActorHorizontallCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = actors[indexPath.row].id
        delegate?.didSelectedActor(id: id)
    }
}

extension ActorHorizontallCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 139, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

