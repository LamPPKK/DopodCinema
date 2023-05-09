//
//  FavoritePopup.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/09.
//

import UIKit
import SDWebImage
import RxSwift
import RxGesture

class FavoritePopup: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    init(type: SearchPagerTag,
         object: SavedInfo) {
        self.type = type
        self.saveInfo = object
        super.init(nibName: "FavoritePopup", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var type: SearchPagerTag
    private var saveInfo: SavedInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        blurView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.tapToOverView()
            }
            .disposed(by: disposeBag)
        
        popupView.corner(radius: 8)
        posterImageView.corner(radius: 8)
        nameLabel.font = .fontPoppinsSemiBold(withSize: 13)
        removeButton.backgroundColor = Constant.Color.color3D5BF6
        removeButton.corner(radius: 8)
        removeButton.setTitleColor(.white, for: .normal)
        
        if let url = URL(string: Utils.getPosterPath(saveInfo.path)) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "ic_loading"))
        } else {
            posterImageView.image = UIImage(named: "ic_loading")
        }
        
        nameLabel.text = saveInfo.name
    }
    
    private func tapToOverView() {
        self.dismiss(animated: false)
    }
    
    func removeMovie(_ id: Int) {
        let list = getListRemove(selectedId: id,
                                 list: UserDataDefaults.shared.getListMovie())
        // Save
        UserDataDefaults.shared.setListMovie(list)
    }
    
    func removeTV(_ id: Int) {
        let list = getListRemove(selectedId: id,
                                 list: UserDataDefaults.shared.getListTV())
        // Save
        UserDataDefaults.shared.setListTV(list)
    }
    
    func removeActove(_ id: Int) {
        let list = getListRemove(selectedId: id,
                                 list: UserDataDefaults.shared.getListActor())
        // Save
        UserDataDefaults.shared.setListActor(list)
    }
    
    func getListRemove(selectedId: Int,
                list: [SavedInfo]) -> [SavedInfo] {
        
        var listRemove = list
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == selectedId {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            listRemove.remove(at: index)
        }
        
        return listRemove
    }
    
    @IBAction func didToRemove() {
        switch type {
        case .kMovie:
            removeMovie(saveInfo.id)
            
        case .kTV:
            removeTV(saveInfo.id)
            
        case .kActor:
            removeActove(saveInfo.id)
        }
        
        NotificationCenter.default.post(name: Notification.Name("Did_change_list_favorite"), object: nil)
        self.dismiss(animated: false)
    }
    
    
}
