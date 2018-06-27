//
//  LocationSelectionViewModel.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation

class LocationSelectionViewModel: NSObject {
    
    var startLocationAddress: Bindable<String> = Bindable("")
    
    var endLocationAddress: Bindable<String> = Bindable("")
    
    override init() {
        super.init()
        addObserver()
    }
    
    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddress(_:)), name: .LocationSelection, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LocationSelectionViewModel {
    @objc func updateAddress(_ notification: Notification) {
        guard let message = notification.userInfo?["address"] as? String else {
            return
        }
        endLocationAddress.value = message
    }
}
