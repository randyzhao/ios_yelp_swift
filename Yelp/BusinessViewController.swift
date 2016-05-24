//
//  BusinessViewController.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController, FiltersViewControllerDelegate {
  
  @IBOutlet weak var businessTableView: UITableView!
  
  var businesses = [Business]()
  var searchFilteredBusinesses = [Business]()
  var filtersButton: UIBarButtonItem!
  let searchBar = UISearchBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
      self.businesses = businesses
      self.searchFilteredBusinesses = businesses
      
      for business in businesses {
        print(business.name!)
        print(business.address!)
      }
      self.businessTableView.reloadData()
    })
    
    businessTableView.delegate = self
    businessTableView.dataSource = self
    
    businessTableView.registerNib(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "businessCell")
    businessTableView.estimatedRowHeight = 100
    businessTableView.rowHeight = UITableViewAutomaticDimension
    
    navigationItem.title = "Yelp"
    filtersButton = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(filtersBarButtonAction))
    filtersButton.title = "Filters"
    navigationItem.leftBarButtonItem = filtersButton
    
    navigationItem.titleView = searchBar
    searchBar.delegate = self
    // Do any additional setup after loading the view.
  }
  
  func filtersBarButtonAction() {
    navigationController?.pushViewController(FiltersViewController(), animated: true)
    let filtersViewController = navigationController?.topViewController as! FiltersViewController
    
    filtersViewController.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters) {
    Filters.sharedInstance = filters
    let categories = [String](filters.categories)
    Business.searchWithTerm("Restaurants", sort: filters.sort, categories: categories, deals: filters.deal, distance: filters.distance) {
      (businesses: [Business]!, error: NSError!) -> Void in
      self.businesses = businesses
      self.performSearch()
    }
  }
}
