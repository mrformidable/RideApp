//
//  AppDelegate.swift
//  RideApp
//
//  Created by Michael A on 2018-06-27.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import UIKit
import GoogleMaps

private let GOOGLE_API_KEY = "AIzaSyDCAnFerD4fyBTs_FpsjUElCpgSf_r4dBM"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GOOGLE_API_KEY)

        return true
    }


}

