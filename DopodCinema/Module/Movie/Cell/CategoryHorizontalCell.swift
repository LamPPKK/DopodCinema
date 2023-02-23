//
//  CategoryHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/15.
//

import UIKit

class CategoryHorizontalCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let CategoryCellIdentity: String = "CategoryCell"
    var categories: [GenreInfo]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: CategoryCellIdentity, bundle: nil), forCellWithReuseIdentifier: CategoryCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension CategoryHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count > 5 ? 5 : categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellIdentity, for: indexPath) as! CategoryCell
        cell.bindData(categories[indexPath.row].name)
        return cell
    }
}

extension CategoryHorizontalCell: UICollectionViewDelegate {
    
}

extension CategoryHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let value: String = categories[indexPath.row].name
        let widthOfText: CGFloat = value.widthOfString(usingFont: .fontInterRegular(withSize: 13))
        let widthPerItem: CGFloat = widthOfText + 48
        return CGSize(width: widthPerItem, height: 34)
    }
}
