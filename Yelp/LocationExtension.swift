//
//  LocationExtension.swift
//  Yelp
//
//  Created by randy_zhao on 5/27/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import CoreLocation

extension BusinessViewController: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    userLocation = locations.last!
    manager.stopUpdatingLocation()
    performSearch()
  }
}