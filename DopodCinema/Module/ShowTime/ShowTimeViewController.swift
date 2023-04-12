//
//  ShowTimeViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit
import CoreLocation

class ShowTimeViewController: BaseViewController<ShowTimeViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var locationTitle: UILabel!
    @IBOutlet private weak var currentLocationName: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let TheaterCellIdentity: String = "TheaterCell"
    private var isFirstTime: Bool = true
    private var currentLocation = CLLocation()
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("show_tabbar"), object: nil)
        
        locationManager.requestWhenInUseAuthorization()
        checkEnbleServiceLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Private function
    private func setupUI() {
        topConstrait.constant = Constant.HEIGHT_NAV
        setupHeader(withTitle: "Showtime")
        
        locationView.corner(radius: 4)
        
        locationTitle.textColor = .black
        locationTitle.font = .fontPoppinsRegular(withSize: 14)
        
        currentLocationName.font = .fontPoppinsSemiBold(withSize: 14)
        currentLocationName.textColor = Constant.Color.color3D5BF6
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constant.BOTTOM_SAFE_AREA + 67, right: 0)
        collectionView.register(UINib(nibName: TheaterCellIdentity, bundle: nil),
                                forCellWithReuseIdentifier: TheaterCellIdentity)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func checkEnbleServiceLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
                self.checkLocationAuthorization()
            } else {
                // Do something
            }
        }
    }
    
    private func getCurrentLocation(at location: Location) {
        if isFirstTime {
            currentLocation = CLLocation(latitude: location.lat, longitude: location.lng)
            getAddress(from: location,
                       completion: { [weak self] name in
                self?.currentLocationName.text = name
            })
            
            viewModel
                .getTheaterNearbyCurrentLocation(at: location,
                                                 completion: { [weak self] in
                    self?.collectionView.reloadData()
                })
            
            isFirstTime = false
        }
    }
}

extension ShowTimeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
        
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            DispatchQueue.main.async {
                self.configUIDenied()
            }
        case .authorizedAlways, .authorizedWhenInUse:
            isFirstTime = true
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = manager.location?.coordinate else {
            return
        }
        
        let location: Location = Location(lat: currentLocation.latitude, lng: currentLocation.longitude)
        getCurrentLocation(at: location)
    }
    
    private func configUIDenied() {
//        if explorePager != nil {
//            explorePager.view.removeFromSuperview()
//        }
//        waringLabel.isHidden = false
//        let appName: String = Bundle.main.infoDictionary!["CFBundleName"] as! String
//        waringLabel.text = "\(appName) need to allow location permission.\nSetting -> \(appName) -> Location."
    }
}

extension ShowTimeViewController {
    func getAddress(from location: Location, completion: @escaping (String) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = location.lat
        center.longitude = location.lng
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                completion(addressString)
            }
        })
    }
}
