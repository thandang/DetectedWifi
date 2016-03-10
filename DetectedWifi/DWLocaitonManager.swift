//
//  DWLocaitonManager.swift
//  DetectedWifi
//
//  Created by Dang Thanh Than on 3/8/16.
//  Copyright © 2016 Than Dang. All rights reserved.
//

import Foundation
import CoreLocation

class DWLocationManager: NSObject, CLLocationManagerDelegate {
    var longtitude: float_t = 0.0
    var lattitude: float_t = 0.0
    var locationManager: CLLocationManager!
    internal var locationManagerDelegate: DWLocationDelegate?
    
    func initialLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager() //Initialize location manager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
        } else {
            print("Location services disabled")
        }
    }
    
    //LocationManager Delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
    }
    
}

protocol DWLocationDelegate {
    func getLocationSuccessful(locations: [CLLocation])
    func getLocationFailed(error: NSError)
}
