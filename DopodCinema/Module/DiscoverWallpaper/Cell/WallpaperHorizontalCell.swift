//
//  WallpaperHorizontalCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/19.
//

import UIKit

protocol WallpaperHorizontalCellDelegate: NSObjectProtocol {
    func didSelectedWallpaper(_ url: String)
}

class WallpaperHorizontalCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let NewCellIdentity: String = "NewCell"
    private var wallpapers: [Wallpaper]!
    weak var delegate: WallpaperHorizontalCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    func bindData(_ wallpapers: [Wallpaper]) {
        self.wallpapers = wallpapers
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UINib(nibName: NewCellIdentity, bundle: nil), forCellWithReuseIdentifier: NewCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionView
extension WallpaperHorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCellIdentity, for: indexPath) as! NewCell
        cell.bindWallpaper(wallpapers[indexPath.row].url_thumb)
        return cell
    }
}

extension WallpaperHorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = wallpapers[indexPath.row].url_image
        delegate?.didSelectedWallpaper(url)
    }
}

extension WallpaperHorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
