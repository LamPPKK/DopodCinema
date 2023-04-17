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
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let DayCellIdentity: String = "DayCell"
    private let ShowTimeCellIdentity: String = "ShowTimeCell"
    
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
        
//        tableView.register(UINib(nibName: ShowTimeCellIdentity, bundle: nil), forCellReuseIdentifier: ShowTimeCellIdentity)
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        tableView.corner(radius: 10)
    }
    
    @objc
    private func getData(notification: Notification) {
        guard let index = notification.object as? Int else {
            return
        }
        
        viewModel.getData(index: index) {
            self.dateCollectionView.reloadData()
        }
    }
}

extension CinemaDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getShowTimes().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCellIdentity, for: indexPath) as! DayCell
        cell.bindData(viewModel.getShowTimes()[indexPath.row])
        return cell
    }
}

extension CinemaDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedIndex = indexPath.row
        viewModel.didSelectedDate(viewModel.getShowTimes()[indexPath.row].date) {
            self.dateCollectionView.reloadData()
//            self.tableView.reloadData()
        }
    }
}

extension CinemaDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem: CGFloat = (collectionView.frame.width - 32) / CGFloat(viewModel.getShowTimes().count)
        return CGSize(width: widthPerItem, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
