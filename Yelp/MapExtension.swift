//
//  MapExtension.swift
//  Yelp
//
//  Created by randy_zhao on 5/27/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension BusinessViewController {
  func getCenterOfBusinesses() -> CLLocation {
    var locationCount: Double = 0
    var totalLongitude: Double = 0
    var totalLatitude: Double = 0
    
    businesses.forEach { (business) in
      if business.longitude != nil && business.latitude != nil {
        locationCount += 1
        totalLatitude += business.latitude!
        totalLongitude += business.longitude!
      }
    }
    return CLLocation(latitude: totalLatitude / locationCount, longitude: totalLongitude / locationCount)
  }
  
  func businessesWithLocations(businesses: [Business]) -> [Business] {
    return businesses.filter({ (business) -> Bool in
      return business.latitude != nil && business.longitude != nil
    })
  }
  
  func latitudeMetersOfBusinesses() -> Double {
    let businesses = businessesWithLocations(self.businesses)
    let latitudes = businesses.map { (business) -> Double in
      return business.latitude!
    }
    let maxLatitude = latitudes.maxElement()!
    let minLatitude = latitudes.minElement()!
    let center = getCenterOfBusinesses()
    let loc1 = CLLocation(latitude: maxLatitude, longitude: center.coordinate.longitude)
    let loc2 = CLLocation(latitude: minLatitude, longitude: center.coordinate.longitude)
    return loc1.distanceFromLocation(loc2)
  }
  
  func longitudeMetersOfBusinesses() -> Double {
    let businesses = businessesWithLocations(self.businesses)
    let longitude = businesses.map { (business) -> Double in
      return business.longitude!
    }
    let maxLongitude = longitude.maxElement()!
    let minLongitude = longitude.minElement()!
    let center = getCenterOfBusinesses()
    let loc1 = CLLocation(latitude: center.coordinate.latitude, longitude: maxLongitude)
    let loc2 = CLLocation(latitude: center.coordinate.latitude, longitude: minLongitude)
    return loc1.distanceFromLocation(loc2)

  }
  
  func centerMap() {
    let region = MKCoordinateRegionMakeWithDistance(getCenterOfBusinesses().coordinate, latitudeMetersOfBusinesses(), longitudeMetersOfBusinesses())
    businessMapView.setRegion(region, animated: true)
  }
  
  func addPins() {
    businessesWithLocations(businesses).forEach { (business) in
      let dropPin = MKPointAnnotation()
      dropPin.coordinate = CLLocation(latitude: business.latitude!, longitude: business.longitude!).coordinate
      dropPin.title = business.name
      businessMapView.addAnnotation(dropPin)
    }
  }
  
  func configMap() {
    centerMap()
    addPins()
  }
}