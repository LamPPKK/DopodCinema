//
//  ShowTimeDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/26.
//

import Foundation

class ShowTimeDetailViewModel {
    
    // MARK: - Properties
    private var movieName: String
    private var listTransform: [TransformShowTime] = []
    
    init(movieName: String) {
        self.movieName = movieName
    }

    func getData(completion: @escaping ((String) -> Void)) {
        LoadingView.shared.startLoading()
        
        API.shared.getShowTimes(with: movieName,
                                completion: { [weak self] showTime in
            guard let self = self else { return }
            
            self.transform(showTime.showtimes)
            LoadingView.shared.endLoading()
            completion(.empty)
        }, error: { error in
            LoadingView.shared.endLoading()
            completion(error.localizedDescription)
        })
    }
    
    func getShowTimes() -> [TransformShowTime] {
        let listContainsSelected = listTransform.filter { $0.isSelected == true }
        if listContainsSelected.isEmpty && !listTransform.isEmpty {
            listTransform[0].isSelected = true
        }
        
        return listTransform
    }
    
    func didSelectedDate(_ date: String, completion: @escaping (() -> Void)) {
        for item in self.listTransform {
            if item.date == date {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
        
        completion()
    }
    
    func getHeightCollectionView(_ times: [String]) -> CGFloat {
        var numberRow = 1
        
        if times.count % 4 == 0 {
            numberRow = times.count / 4
        } else {
            for index in 0..<times.count {
                if (index + 1) % 4 == 0 {
                    numberRow += 1
                }
            }
        }
        
        return CGFloat(numberRow * (32 + 12))
    }
    
    private func transform(_ list: [ShowTimesInfo]) {
        self.listTransform = list.map {
            return TransformShowTime(day: $0.day,
                                     date: $0.date,
                                     isSelected: false,
                                     theaters: $0.theaters)
        }
    }
}
