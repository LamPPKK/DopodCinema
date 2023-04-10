//
//  ShowTimeViewController+CollectionView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import UIKit

extension ShowTimeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTheaters().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TheaterCellIdentity, for: indexPath) as! TheaterCell
        cell.bindData(viewModel.getTheaters()[indexPath.row])
        return cell
    }
}

extension ShowTimeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = viewModel.getTheaters()[indexPath.row].name
        viewModel.gotoCinemaDetail(with: name,
                                   completion: { [weak self] msg in
            guard let self = self else { return }
            
            if !msg.isEmpty {
                self.showAlert(with: "Notifaction",
                               msg: "This cinema currently do not have any showtimes")
            }
        })
    }
}

extension ShowTimeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
