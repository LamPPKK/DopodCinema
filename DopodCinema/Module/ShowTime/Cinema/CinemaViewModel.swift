//
//  CinemaViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation

class CinemaViewModel {
    // MARK: - Properties
    private var moviesCinema: [MovieCinema]
    private var selectedIndex: Int = 2 // default value
    private var listDate: [TransformShowTime] = []
    
    init(moviesCinema: [MovieCinema]) {
        self.moviesCinema = moviesCinema
    }
    
    func getMoviesCinema() -> [MovieCinema] {
        self.moviesCinema
    }
    
    func setSelectedIndex(_ index: Int) {
        self.selectedIndex = index
    }
    
    func getSelectedIndex() -> Int {
        self.selectedIndex
    }
    
    func getCategories() -> [GenreInfo] {
        return UserDataDefaults.shared.getCategories().map {
            return GenreInfo(id: $0.id, name: $0.name)
        }
    }
    
    func getData(index: Int, completion: @escaping () -> Void) {
        LoadingView.shared.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.listDate = self.moviesCinema[index].getDays()
            LoadingView.shared.endLoading()
            completion()
        })
    }
    
    func getShowTimes() -> [TransformShowTime] {
        let listContainsSelected = self.listDate.filter { $0.isSelected == true }
        if listContainsSelected.isEmpty && !self.listDate.isEmpty {
            self.listDate[0].isSelected = true
        }
        
        return self.listDate
    }
    
    func didSelectedDate(_ date: String, completion: @escaping (() -> Void)) {
        for item in self.listDate {
            if item.date == date {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
        
        completion()
    }
}
