//
//  ShowTimeCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/30.
//

import UIKit

class ShowTimeCell: UITableViewCell {

    @IBOutlet private weak var theaterNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    @IBOutlet private weak var trailingCollectionView: NSLayoutConstraint!
    
    // MARK: - Property
    private let TimeCellIdentity: String = "TimeCell"
    private let itemsPerRow: CGFloat = 4
    private let widthItem: CGFloat = 78
    private let heightItem: CGFloat = 32
    private let spacing: CGFloat = 12
    private let leading: CGFloat = 16
    
    var times: [String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        theaterNameLabel.textColor = .black
        theaterNameLabel.font = .fontPoppinsSemiBold(withSize: 16)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: TimeCellIdentity, bundle: nil), forCellWithReuseIdentifier: TimeCellIdentity)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let trailingConstraint: CGFloat = UIScreen.main.bounds.width - (itemsPerRow * widthItem) - ((itemsPerRow - 1) * spacing) - leading
        trailingCollectionView.constant = trailingConstraint
        
    }
    
    func bindData(_ data: TheaterInfo) {
        theaterNameLabel.text = data.name
        
        collectionView.reloadData()
    }
}

// MARK: - Extension UICollectionView
extension ShowTimeCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCellIdentity, for: indexPath) as! TimeCell
        cell.bindData(times[indexPath.row])
        return cell
    }
}

extension ShowTimeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthItem, height: heightItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
