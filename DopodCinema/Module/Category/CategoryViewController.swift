//
//  CategoryViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/06.
//

import UIKit

class CategoryViewController: BaseViewController<CategoryViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let CategoryCellIdentity: String = "CategoryCell"
    let ImageCellIdentity: String = "ImageCell"
    let itemsPerRow: CGFloat = 3
    let heightPerItem: CGFloat = 158
    let lineSpacing: CGFloat = 16
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        if let selectedIndex = selectedIndex {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.categoryCollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0),
                                                    at: .centeredHorizontally,
                                                    animated: true)
            })
        }
        
        viewModel.getData(with: viewModel.idCategory) {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: "Category")
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        categoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        categoryCollectionView.register(UINib(nibName: CategoryCellIdentity, bundle: nil), forCellWithReuseIdentifier: CategoryCellIdentity)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.tag = CollectionViewTag.category.rawValue
        
        collectionView.register(UINib(nibName: ImageCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageCellIdentity)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.tag = CollectionViewTag.movies.rawValue
    }
}
