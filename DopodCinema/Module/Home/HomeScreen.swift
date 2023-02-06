//
//  HomeScreen.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift

class HomeScreen: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var movieNavView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDotImageView: UIImageView!
    @IBOutlet private weak var tvNavView: UIView!
    @IBOutlet private weak var tvImageView: UIImageView!
    @IBOutlet private weak var tvDotImageView: UIImageView!
    @IBOutlet private weak var favNavView: UIView!
    @IBOutlet private weak var favImageView: UIImageView!
    @IBOutlet private weak var favDotImageView: UIImageView!
    @IBOutlet private weak var discoveryNavView: UIView!
    @IBOutlet private weak var discoveryImageView: UIImageView!
    @IBOutlet private weak var discoveryDotImageView: UIImageView!
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        let tapMovie = UITapGestureRecognizer()
        movieNavView.isUserInteractionEnabled = true
        movieNavView.addGestureRecognizer(tapMovie)
        
        tapMovie
            .rx
            .event
            .bind { [weak self] _ in
                self?.handleTapMovie()
            }
            .disposed(by: disposeBag)
        
        let tapTV = UITapGestureRecognizer()
        tvNavView.isUserInteractionEnabled = true
        tvNavView.addGestureRecognizer(tapTV)
        
        tapTV
            .rx
            .event
            .bind { [weak self] _ in
                self?.handleTapTV()
            }
            .disposed(by: disposeBag)
        
        let tapFav = UITapGestureRecognizer()
        favNavView.isUserInteractionEnabled = true
        favNavView.addGestureRecognizer(tapFav)
        
        tapFav
            .rx
            .event
            .bind { [weak self] _ in
                self?.handleTapFav()
            }
            .disposed(by: disposeBag)
        
        let tapDiscovery = UITapGestureRecognizer()
        discoveryNavView.isUserInteractionEnabled = true
        discoveryNavView.addGestureRecognizer(tapDiscovery)
        
        tapDiscovery
            .rx
            .event
            .bind { [weak self] _ in
                self?.handleTapDiscovery()
            }
            .disposed(by: disposeBag)
        
        tvDotImageView.isHidden = true
        favDotImageView.isHidden = true
        discoveryDotImageView.isHidden = true
    }
    
    private func handleTapMovie() {
        handleTap(isActiveMovie: true)
    }
    
    private func handleTapTV() {
        handleTap(isActiveTV: true)
    }
    
    private func handleTapFav() {
        handleTap(isActiveFav: true)
    }
    
    private func handleTapDiscovery() {
        handleTap(isActiveDiscovery: true)
    }
    
    private func handleTap(isActiveMovie: Bool = false,
                           isActiveTV: Bool = false,
                           isActiveFav: Bool = false,
                           isActiveDiscovery: Bool = false) {
        movieImageView.image = UIImage(named: isActiveMovie ? "ic_home_active" : "ic_home_inactive")
        tvImageView.image = UIImage(named: isActiveTV ? "ic_play_active" : "ic_play_inactive")
        favImageView.image = UIImage(named: isActiveFav ? "ic_fav_active" : "ic_fav_inactive")
        discoveryImageView.image = UIImage(named: isActiveDiscovery ? "ic_discovery_active" : "ic_discovery_inactive")
        
        movieDotImageView.isHidden = !isActiveMovie
        tvDotImageView.isHidden = !isActiveTV
        favDotImageView.isHidden = !isActiveFav
        discoveryDotImageView.isHidden = !isActiveDiscovery
    }
}
