//
//  ShowTimeDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/18.
//

import UIKit

class ShowTimeDetailViewController: BaseViewController<ShowTimeDetailViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var dateCollectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let DayCellIdentity: String = "DayCell"
    private let ShowTimeCellIdentity: String = "ShowTimeCell"
    
    private var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        viewModel.getData(completion: {
            self.dateCollectionView.reloadData()
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Private functions
    private func setupUI() {
        dateCollectionView.register(UINib(nibName: DayCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: DayCellIdentity)
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        
        tableView.register(UINib(nibName: ShowTimeCellIdentity, bundle: nil), forCellReuseIdentifier: ShowTimeCellIdentity)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.corner(radius: 10)
    }
}

extension ShowTimeDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getShowTimes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCellIdentity, for: indexPath) as! DayCell
        cell.bindData(viewModel.getShowTimes()[indexPath.row])
        return cell
    }
}

extension ShowTimeDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        viewModel.didSelectedDate(viewModel.getShowTimes()[indexPath.row].date) {
            self.dateCollectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}

extension ShowTimeDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem: CGFloat = (collectionView.frame.width - 32) / CGFloat(viewModel.getShowTimes().count)
        return CGSize(width: widthPerItem, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

extension ShowTimeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedIndex = self.selectedIndex {
            return viewModel.getShowTimes()[selectedIndex].theaters.count
        } else {
            return viewModel.getShowTimes().first?.theaters.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowTimeCellIdentity) as! ShowTimeCell
        
        var theaters: [TheaterInfo] = []
        
        if let selectedIndex = self.selectedIndex {
            theaters = viewModel.getShowTimes()[selectedIndex].theaters
        } else {
            theaters = viewModel.getShowTimes().first?.theaters ?? []
        }
        
        let theaterInfo: TheaterInfo = theaters[indexPath.row]
        cell.heightOfCollectionView.constant = viewModel.getHeightCollectionView(theaterInfo.showing.first?.time ?? [])
        cell.times = theaterInfo.showing.first?.time
        cell.bindData(theaterInfo)
        return cell
    }
}

extension ShowTimeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
