//
//  WallpaperPreviewViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/19.
//

import UIKit
import Photos

class WallpaperPreviewViewController: BaseViewController<BaseViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var wallpaperImageView: UIImageView!
    @IBOutlet private weak var optionsBottomSheet: UIView!
    @IBOutlet private weak var saveView: UIView!
    @IBOutlet private weak var saveLabel: UILabel!
    @IBOutlet private weak var shareView: UIView!
    @IBOutlet private weak var shareLabel: UILabel!
    @IBOutlet private weak var heightOfBottomSheet: NSLayoutConstraint!
    
    // MARK: - Properties
    private let heightValue: CGFloat = 130
    private var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: "WallpaperPreviewViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private functions
    private func setupView() {
        setupSubHeader(with: .empty, isBackWhite: true)
        
        if let wallpaperURL = URL(string: url) {
            wallpaperImageView.sd_setImage(with: wallpaperURL,
                                           placeholderImage: UIImage(named: "ic_loading"))
        } else {
            wallpaperImageView.image = UIImage(named: "ic_loading")
        }
                
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapOverWallpaper))
        wallpaperImageView.isUserInteractionEnabled = true
        wallpaperImageView.addGestureRecognizer(singleTap)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapToWallpaper))
        wallpaperImageView.isUserInteractionEnabled = true
        wallpaperImageView.addGestureRecognizer(longTap)
        
        optionsBottomSheet.isHidden = true
        optionsBottomSheet.corner(radius: 12)
        
        let tapSave = UITapGestureRecognizer(target: self, action: #selector(tapToDownload))
        saveView.isUserInteractionEnabled = true
        saveView.addGestureRecognizer(tapSave)
        
        saveView.corner(radius: saveView.frame.height / 2)
        saveView.backgroundColor = Constant.Color.color4E69F7
        saveLabel.text = "Download"
        saveLabel.textColor = .white
        saveLabel.font = .fontPoppinsMedium(withSize: 13)
        
        let tapShare = UITapGestureRecognizer(target: self, action: #selector(tapToShare))
        shareView.isUserInteractionEnabled = true
        shareView.addGestureRecognizer(tapShare)
        
        shareView.corner(radius: saveView.frame.height / 2)
        shareView.backgroundColor = Constant.Color.color4E69F7
        shareLabel.text = "Share"
        shareLabel.textColor = .white
        shareLabel.font = .fontPoppinsMedium(withSize: 13)
    }
    
    @objc
    private func tapOverWallpaper() {
        optionsBottomSheet.isHidden = true
    }
    
    @objc
    private func longTapToWallpaper() {
        optionsBottomSheet.isHidden = false
    }
    
    @objc
    private func tapToDownload() {
        optionsBottomSheet.isHidden = true
        
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
                        UIImageWriteToSavedPhotosAlbum(self.wallpaperImageView.image ?? UIImage(),
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
            showAlert(with: "DopodCinema would like to Access Your Photos.",
                      msg: "Settings -> Dopod Cinema -> Photos")
            
        case .authorized:
            UIImageWriteToSavedPhotosAlbum(wallpaperImageView.image ?? UIImage(),
                                           self,
                                           #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                           nil)
        @unknown default:
            fatalError()
        }
    }
    
    @objc
    private func tapToShare() {
        optionsBottomSheet.isHidden = true
        
        let wallpaperURL = URL(string: url)
        let textTitle = "Dopod cinema want to share this wallpaper."
        let sharedObjects: [AnyObject] = [wallpaperURL as AnyObject,
                                          textTitle as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: sharedObjects,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
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
