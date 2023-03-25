//
//  FavoriteActorViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import Foundation

class FavoriteActorViewModel {
    func getListFavorite() -> [SavedInfo] {
        return UserDataDefaults.shared.getListActor()
    }
}
