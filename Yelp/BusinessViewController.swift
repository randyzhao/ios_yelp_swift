//
//  BusinessViewController.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessViewController: UIViewController, FiltersViewControllerDelegate {
  
  @IBOutlet weak var businessMapView: MKMapView!
  @IBOutlet weak var businessTableView: UITableView!
  
  var businesses = [Business]()
  var filtersButton: UIBarButtonItem!
  let searchBar = UISearchBar()
  var mapOrListViewButton: UIBarButtonItem!
  var isMoreDataLoading = false
  var searchTerm = ""
  var loadingMoreView: InfiniteScrollActivityView?
  var locationManager: CLLocationManager!
  var userLocation: CLLocation = CLLocation(latitude: 37.785771, longitude: -122.406165)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    businessTableView.delegate = self
    businessTableView.dataSource = self
    //performSearch()
    
    businessTableView.registerNib(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "businessCell")
    businessTableView.estimatedRowHeight = 100
    businessTableView.rowHeight = UITableViewAutomaticDimension
    
    navigationItem.title = "Yelp"
    filtersButton = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(filtersBarButtonAction))
    filtersButton.title = "Filters"
    navigationItem.leftBarButtonItem = filtersButton
    
    navigationItem.titleView = searchBar
    searchBar.delegate = self
    searchBar.enablesReturnKeyAutomatically = false
    
    mapOrListViewButton = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(mapOrListViewButtonAction))
    navigationItem.rightBarButtonItem = mapOrListViewButton
    
    // Set up Infinite Scroll loading indicator
    let frame = CGRectMake(0, businessTableView.contentSize.height, businessTableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
    loadingMoreView = InfiniteScrollActivityView(frame: frame)
    loadingMoreView!.hidden = true
    businessTableView.addSubview(loadingMoreView!)
    
    var insets = businessTableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    businessTableView.contentInset = insets
    
    if (CLLocationManager.locationServicesEnabled())
    {
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
    }
  }
  
  func filtersBarButtonAction() {
    navigationController?.pushViewController(FiltersViewController(), animated: true)
    let filtersViewController = navigationController?.topViewController as! FiltersViewController
    
    filtersViewController.delegate = self
  }
  
  func mapOrListViewButtonAction() {
    if businessTableView.hidden {
      // Map view is live
      businessTableView.hidden = false
      businessMapView.hidden = true
      mapOrListViewButton.title = "Map"
    } else {
      businessTableView.hidden = true
      businessMapView.hidden = false
      mapOrListViewButton.title = "List"
      configMap()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters) {
    Filters.sharedInstance = filters
    performSearch()
  }
}
