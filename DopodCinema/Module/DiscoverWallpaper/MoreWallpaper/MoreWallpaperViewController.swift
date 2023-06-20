//
//  MoreWallpaperViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 20/06/2023.
//

import UIKit

class MoreWallpaperViewController: BaseViewController<MoreWallpaperViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    init() {
        super.init(nibName: "MoreWallpaperViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let ImageCellIdentity: String = "ImageCell"
    private let itemsPerRow: CGFloat = 3
    private let lineSpacing: CGFloat = 5
    private var heightPerItem: CGFloat = 165
    private var page: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        viewModel.getData {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Private functions
    private func setupViews() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: "More Wallpaper")
        setupCollectionView()
        loadingView.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ImageCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
extension MoreWallpaperViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getWallpapers().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentity, for: indexPath) as! ImageCell
        cell.bindWallpaper(viewModel.getWallpapers()[indexPath.row].url_thumb)
        return cell
    }
}

extension MoreWallpaperViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wallpaperURL = viewModel.getWallpapers()[indexPath.row].url_image
        viewModel.gotoWallpaperPreview(wallpaperURL)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getWallpapers().count - 1 {
            loadingView.startAnimating()
            loadingView.isHidden = false
            loadMoreData(at: page)
        } else {
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
    
    private func loadMoreData(at page: Int) {
        viewModel.getWallpapers(at: page) { [weak self] isSucceeded in
            guard let self = self else { return }
            if isSucceeded {
                self.collectionView.reloadData()
                self.page += 1
            }
        }
    }
}

extension MoreWallpaperViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = (lineSpacing * (itemsPerRow - 1)) + 32
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        if UIDevice.current.userInterfaceIdiom == .pad {
            heightPerItem = widthPerItem / 0.75
        }
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}
