//
//  MapViewController+Delegates.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

extension MapViewController: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        if let coordinate = locationManager.recentLocation?.coordinate {
            let position = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14)
            CATransaction.begin()
            CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
            mapView.animate(to: position)
            CATransaction.commit()
        }
        return false
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let target = mapView.camera.target
        locationManager.geocodeAddress(coordinate: target) { (response, error) in
            if error != nil { print(error!.localizedDescription); return }
            guard let address = response?.results()?.first?.lines?.first else {
                return
            }
            self.sendLocationSelectionUpdate(address)
        }
        markerFactory.moveEndingLocationMarker(to: target)
        mapViewModel?.fetchRides(bounds: target, secondCoordinate: target)
    }
    
    func sendLocationSelectionUpdate(_ address: String) {
        let addressDict = ["address": address]
        NotificationCenter.default.post(name: .LocationSelection, object: nil, userInfo: addressDict)
    }
    
}
extension MapViewController: LocationManagerDelegate {
    func handleUserLocationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .restricted: fallthrough
        case .denied:
           handleLocationDenial()
        case .notDetermined:
            locationManager.requestLocationUsageAuthorization()
        case .authorizedWhenInUse:
            setupMapView()
        default:
            break
        }
    }
    
    private func handleLocationDenial() {
        mapView?.isHidden = true
        finishButton.isHidden = true
        containerView.isHidden = false
        backgroundImageView.isHidden = false
        locationSelectionView?.isHidden = true
        mapView?.removeFromSuperview()
        mapView = nil
        locationManager.stopLocationUpdates()
    }
}

extension MapViewController: RideConfirmationViewDelegate {
    func confirmPaymentButtonTapped() {
      handlePaymentConfirmation()
    }
    
    private func handlePaymentConfirmation() {
        mapView?.isUserInteractionEnabled = true
        mapView?.clear()
        bottomRideConfirmationViewConstraint?.constant = Constants.Constraints.rideConfirmationViewBottomConstraint
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        markerFactory.placeInitialLocationMarker(map: mapView!, position: recentLocationCoordinate!)
        markerFactory.placeEndingLocationMarker(map: mapView!, position: recentLocationCoordinate!)
    }
    
    func taxiIconButtonTapped() {
        showRideListVC()
    }
    
    func poolIconButtonTapped() {
        showRideListVC()
    }
    
    func showRideListVC() {
        performSegue(withIdentifier: Constants.SegueIdentifiers.rideListControllerSegue, sender: self)
    }
    
}
