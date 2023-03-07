//
//  CategoryViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/06.
//

import Foundation

class CategoryInfo {
    let id: Int
    let name: String
    var isSelected: Bool
    
    init(id: Int, name: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}

class CategoryViewModel {
    // MARK: - Properties
    private var navigator: CategoryNavigator
    private var categories: [GenreInfo]
    private var categoriesInfo: [CategoryInfo] = []
    private var moviesCategory: [MovieInfo] = []
    var idCategory: Int
    
    init(navigator: CategoryNavigator,
         categories: [GenreInfo],
         idCategory: Int) {
        self.navigator = navigator
        self.categories = categories
        self.idCategory = idCategory
        
        handleCategories()
    }
    
    func getCategories() -> [CategoryInfo] {
        self.categoriesInfo
    }
    
    func setCategories(_ list: [CategoryInfo]) {
        self.categoriesInfo = list
    }
    
    private func handleCategories(){
        categoriesInfo = categories
            .map {
                return CategoryInfo(id: $0.id, name: $0.name, isSelected: false)
            }
            .map {
                return CategoryInfo(id: $0.id, name: $0.name, isSelected: $0.id == self.idCategory)
            }
    }
    
    func didSelectedCategory(with id: Int, completion: @escaping (() -> Void)) {
        for category in self.categoriesInfo {
            if category.id == id {
                category.isSelected = true
            } else {
                category.isSelected = false
            }
        }
        
        getData(with: id) {
            completion()
        }
    }
    
    func getData(with categoryID: Int,
                 completion: @escaping (() -> Void)) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovies(with: categoryID,
                             completion: { [weak self] moviesCategory in
            guard let self = self else { return }
            
            self.moviesCategory = moviesCategory
            LoadingView.shared.endLoading()
            completion()
        }, error: { _ in
            LoadingView.shared.endLoading()
            completion()
        })
    }
    
    func getMoviesCategory() -> [MovieInfo] {
        moviesCategory
    }
    
    func showMovieDetailInfo(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
