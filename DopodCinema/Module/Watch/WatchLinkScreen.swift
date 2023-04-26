//
//  WatchLinkScreen.swift
//  Uxim
//
//  Created by The Ngoc on 2023/01/18.
//

import UIKit

class WatchLinkScreen: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var serverLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var containerNativeAd: UIView!
    @IBOutlet private weak var heightOfNativeAd: NSLayoutConstraint!
    
    // MARK: - Property
    private let ServerCellIdentity: String = "ServerCell"
    private let itemsPerRow: CGFloat = 5
    private let leadingSpacing: CGFloat = 12
    private let heightPerItem: CGFloat = 44
    
    init(data: LinkContainerInfo) {
        self.data = data
        super.init(nibName: "WatchLinkScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var data: LinkContainerInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        serverLabel.text = "Server"
        serverLabel.font = UIFont.fontPoppinsBold(withSize: 16)
        serverLabel.textColor = .white
        
        self.containerNativeAd.isHidden = true
        self.heightOfNativeAd.constant = 0
        
        collectionView.register(UINib(nibName: ServerCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: ServerCellIdentity)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: leadingSpacing,
                                           left: leadingSpacing,
                                           bottom: 0,
                                           right: leadingSpacing)
        collectionView.collectionViewLayout = layout
    }
}

extension WatchLinkScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServerCellIdentity, for: indexPath) as! ServerCell
        cell.bindData(with: indexPath.row)
        return cell
    }
}

extension WatchLinkScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showFullLink(index: indexPath.row)
    }
    
    private func showFullLink(index: Int) {
        let linkFullMovie: String = data.data[index].links.first ?? .empty
        let webViewScreen = WebViewScreen(title: .empty, url: linkFullMovie)
        webViewScreen.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webViewScreen, animated: true)
    }
}

extension WatchLinkScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Leading + Trailing of Collection View + spacing between items
        let paddingSpace: CGFloat = leadingSpacing * 2 + (leadingSpacing * itemsPerRow - 1)
        let availableWidth: CGFloat = collectionView.frame.width - paddingSpace
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return leadingSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return leadingSpacing
    }
}
