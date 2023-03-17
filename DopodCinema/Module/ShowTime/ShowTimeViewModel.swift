//
//  ShowTimeViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import Foundation

class ShowTimeViewModel {
    
    // MARK: - Properties
    private var theaters: [MovieTheaterSearchInfo] = []
    
    func getTheaterNearbyCurrentLocation(at location: Location, completion: @escaping () -> Void) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieTheaters(at: location, completion: { [weak self] theaterInfos in
            guard let self = self else {
                return
            }
            
            self.theaters = theaterInfos
            completion()
            LoadingView.shared.endLoading()
        }, error: { _ in
            completion()
            LoadingView.shared.endLoading()
        })
    }
    
    func getTheaters() -> [MovieTheaterSearchInfo] {
        self.theaters
    }
}
