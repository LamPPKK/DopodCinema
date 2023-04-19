//
//  CinemaDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import UIKit

class CinemaDetailViewController: BaseViewController<CinemaViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var dateCollectionView: UICollectionView!
    @IBOutlet private weak var timeCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let DayCellIdentity: String = "DayCell"
    private let TimeCellIdentity: String = "TimeCell"
    private let itemsPerRow: CGFloat = 4
    private let widthItem: CGFloat = 78
    private let heightItem: CGFloat = 32
    private let spacing: CGFloat = 12
    private let leading: CGFloat = 16
    
    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getData),
                                               name: Notification.Name("cinema_reload"),
                                               object: nil)
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private functions
    private func setupUI() {
        dateCollectionView.register(UINib(nibName: DayCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: DayCellIdentity)
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.tag = CollectionViewTag.date.rawValue
        dateCollectionView.contentInset = UIEdgeInsets(top: 0, left: leading, bottom: 0, right: leading)
        
        timeCollectionView.register(UINib(nibName: TimeCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: TimeCellIdentity)
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.tag = CollectionViewTag.time.rawValue
        timeCollectionView.contentInset = UIEdgeInsets(top: leading, left: leading, bottom: 0, right: leading)
    }
    
    @objc
    private func getData(notification: Notification) {
        guard let index = notification.object as? Int else {
            return
        }
        
        selectedIndex = 0
        viewModel.setEmptyShowTimes()
        viewModel.getData(index: index) {
            self.dateCollectionView.reloadData()
            self.timeCollectionView.reloadData()
        }
    }
}

extension CinemaDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .date:
            return viewModel.getShowTimes().count
            
        case .time:
            if viewModel.getShowTimes().isEmpty {
                return 0
            } else {
                return viewModel.getShowTimes()[selectedIndex].times.count
            }
            
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .date:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCellIdentity, for: indexPath) as! DayCell
            cell.bindData(viewModel.getShowTimes()[indexPath.row])
            return cell
            
        case .time:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCellIdentity, for: indexPath) as! TimeCell
            let times = viewModel.getShowTimes()[selectedIndex].times
            let time = times[indexPath.row]
            cell.bindData(time)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension CinemaDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .date:
            self.selectedIndex = indexPath.row
            viewModel.didSelectedDate(viewModel.getShowTimes()[indexPath.row].date) {
                self.dateCollectionView.reloadData()
                self.timeCollectionView.reloadData()
            }
            
        case .time:
            break
            
        default:
            break
        }
    }
}

extension CinemaDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = CollectionViewTag(rawValue: collectionView.tag)
        
        switch tag {
        case .date:
            let widthPerItem: CGFloat = (collectionView.frame.width - 32) / CGFloat(viewModel.getShowTimes().count)
            return CGSize(width: widthPerItem, height: 80)
            
        case .time:
            return CGSize(width: widthItem, height: heightItem)
            
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
