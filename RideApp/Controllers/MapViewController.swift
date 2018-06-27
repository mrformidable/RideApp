//
//  MapViewController.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

final class MapViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            finishButton.layer.cornerRadius = 10
        }
    }
    
    var locationManager: LocationManager!
    var mapView: GMSMapView?
    var locationSelectionView: LocationSelectionView?
    var rideConfirmationView: RideConfirmationView?
    let markerFactory = MapMarkerManager()
    var bottomRideConfirmationViewConstraint: NSLayoutConstraint?
    var mapViewModel: MapViewModel?
    private let locationSelectionViewModel = LocationSelectionViewModel()
    private lazy var rideRequestManager = RideRequestManager(locationManger: locationManager)
    var recentLocationCoordinate: CLLocationCoordinate2D? {
        return locationManager.recentLocation?.coordinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManger()
        
        guard let coordinate = locationManager.recentLocation?.coordinate else {
            return
        }
        locationManager.geocodeAddress(coordinate: coordinate) { (response, error) in
            if error != nil { print(error!.localizedDescription); return }
            guard let address = response?.results()?.first?.lines?.first else {
                return
            }
            self.locationSelectionView?.startLocationTextField.text = address
        }
        
        locationSelectionViewModel.endLocationAddress.bind { (address) in
            self.locationSelectionView?.endLocationTextField.text = address
        }
    }
    
    func setupMapView() {
        if let position = locationManager.recentLocation?.coordinate {
            let camera = GMSCameraPosition.camera(withTarget: position, zoom: 14)
            mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            mapView?.backgroundColor = .white
            mapView?.settings.myLocationButton = true
            mapView?.settings.rotateGestures = false
            mapView?.delegate = self
            guard let mapStyleUrl = Bundle.main.url(forResource: "mapStyle", withExtension: "json") else {
                return
            }
            mapView?.mapStyle = try? GMSMapStyle(contentsOfFileURL: mapStyleUrl)
            view.insertSubview(mapView!, at: 0)
            locationManager.mapView = mapView
            mapViewModel = MapViewModel(service: RideApiNetworkService(), map: mapView!)
            setupViews()
            markerFactory.placeInitialLocationMarker(map: mapView!, position: locationManager.recentLocation!.coordinate)
            markerFactory.placeEndingLocationMarker(map: mapView!, position:mapView!.camera.target)
            
            let position = CLLocationCoordinate2D(latitude: 53.552909, longitude: 9.985854)
            markerFactory.place(map: mapView!, position: position, iconImage: #imageLiteral(resourceName: "taxi_icon"))
        }
    }
    
    private func setupViews() {
        self.locationSelectionView = LocationSelectionView()
        view.addSubview(locationSelectionView!)
        locationSelectionView?.anchorConstraints(topAnchor: menuButton.bottomAnchor, topConstant: 20, leftAnchor: view.leftAnchor, leftConstant: 20, rightAnchor: view.rightAnchor, rightConstant: -20, bottomAnchor: nil, bottomConstant: 0, heightConstant: 100, widthConstant: 0)
        
        rideConfirmationView = RideConfirmationView(frame: .zero)
        rideConfirmationView?.layer.cornerRadius = 5
        rideConfirmationView?.delegate = self
        view.addSubview(rideConfirmationView!)
        rideConfirmationView?.anchorConstraints(topAnchor: nil, topConstant: 0, leftAnchor: view.leftAnchor, leftConstant: 5, rightAnchor: view.rightAnchor, rightConstant: -5, bottomAnchor: nil, bottomConstant: 0, heightConstant: 220, widthConstant: 0)
        
        bottomRideConfirmationViewConstraint = rideConfirmationView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.Constraints.rideConfirmationViewBottomConstraint)
        bottomRideConfirmationViewConstraint?.isActive = true
        
        backgroundImageView.isHidden = true
        containerView.isHidden = true
        locationSelectionView?.isHidden = false
        finishButton.isHidden = false
    }
    
    func setupConfirmationAnimation() {
        bottomRideConfirmationViewConstraint?.constant = -10
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupLocationManger() {
        locationManager = LocationManager()
        locationManager.setDesiredLocationAccuracy(kCLLocationAccuracyBest)
        locationManager.requestLocationUsageAuthorization()
        locationManager.delegate = self
        locationManager.startLocationUpdates()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        print("menu button tapped")
    }
    
    @IBAction func turnLocationServicesButtonTapped(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        let startingLocation = CLLocation(latitude: recentLocationCoordinate!.latitude, longitude: recentLocationCoordinate!.longitude)
        
        let endingLocation = CLLocation(latitude: markerFactory.endingLocationMarker!.position.latitude, longitude: markerFactory.endingLocationMarker!.position.longitude)
        
        let cost = rideRequestManager.calculateRideCost(startingLocation, endLocation: endingLocation)
        
        rideRequestManager.requestRide(startingLocation, endLocation: endingLocation, cost: cost)
        
        rideRequestManager.drawPath(on: mapView!, startCoordinate: locationManager.recentLocation!.coordinate, endCoordinate: markerFactory.endingLocationMarker!.position)
        mapView?.isUserInteractionEnabled = false
        setupConfirmationAnimation()
    }
}





