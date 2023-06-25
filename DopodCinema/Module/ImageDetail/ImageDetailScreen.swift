//
//  ImageDetailScreen.swift
//  Uxim
//
//  Created by The Ngoc on 2022/12/11.
//

import UIKit
import Photos

class ImageDetailScreen: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Property
    private let ImageDetailCellIdentity: String = "ImageDetailCell"
    
    private var images: [ImageInfo]
    private var selectedIndex: Int
    
    init(selectedIndex: Int, images: [ImageInfo]) {
        self.selectedIndex = selectedIndex
        self.images = images
        super.init(nibName: "ImageDetailScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        collectionView.register(UINib(nibName: ImageDetailCellIdentity, bundle: nil), forCellWithReuseIdentifier: ImageDetailCellIdentity)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let selectedIndexPath = IndexPath(row: self.selectedIndex, section: 0)
            self.collectionView.scrollToItem(at: selectedIndexPath,
                                             at: .centeredHorizontally,
                                             animated: false)
            self.collectionView.isPagingEnabled = true
        }
    }
    
    // MARK: - IBAction
    @IBAction func didMoveToClose() {
        navigationController?.popViewController(animated: true)
    }
}

extension ImageDetailScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailCellIdentity, for: indexPath) as! ImageDetailCell
        cell.bindData(images[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension ImageDetailScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightPerItem: CGFloat = collectionView.frame.height
        let widthPerItem: CGFloat = collectionView.frame.width
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ImageDetailScreen: ImageDetailCellDelegate {
    func showBottomSheet(with selectedImage: UIImage) {
        let bottomSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save Image", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
                
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    DispatchQueue.main.async {
                        switch newStatus {
                        case .notDetermined,
                                .limited,
                                .denied,
                                .restricted:
                            self.showAlert(with: "DopodCinema would like to Access Your Photos.",
                                           msg: "Settings -> Dopod Cinema -> Photos")
                            
                        case .authorized:
                            UIImageWriteToSavedPhotosAlbum(selectedImage,
                                                           self,
                                                           #selector(self.image(_:didFinishSavingWithError:contextInfo:)),
                                                           nil)
                            
                        @unknown default:
                            fatalError()
                        }
                    }
                }
                
            case .restricted,
                    .denied,
                    .limited:
                self.showAlert(with: "DopodCinema would like to Access Your Photos.",
                          msg: "Settings -> Dopod Cinema -> Photos")
                
            case .authorized:
                UIImageWriteToSavedPhotosAlbum(selectedImage,
                                               self,
                                               #selector(self.image(_:didFinishSavingWithError:contextInfo:)),
                                               nil)
            @unknown default:
                fatalError()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        bottomSheet.addAction(saveAction)
        bottomSheet.addAction(cancelAction)
        
        present(bottomSheet, animated: true)
    }
    
    @objc
    private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        var message: String = .empty
        if error != nil {
            message = error?.localizedDescription ?? .empty
        } else {
            message = "Saved Image!"
        }
        
        self.showAlert(msg: message)
    }
}
