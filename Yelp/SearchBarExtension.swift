//
//  SearchBarExtension.swift
//  Yelp
//
//  Created by randy_zhao on 5/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension BusinessViewController: UISearchBarDelegate {
  func performSearch() {
    let filters = Filters.sharedInstance

    Business.searchWithTerm(searchTerm, sort: filters.sort, categories: [String](filters.categories), deals: filters.deal, distance: filters.distance) {
      (businesses: [Business]!, error: NSError!) -> Void in
      self.businesses = businesses
      self.businessTableView.reloadData()
    }
  }
  
  func loadMoreData() {
    let filters = Filters.sharedInstance
    
    Business.searchWithTerm(searchTerm, sort: filters.sort, categories: [String](filters.categories), deals: filters.deal, distance: filters.distance, offset: businesses.count) {
      (businesses: [Business]!, error: NSError!) -> Void in
      self.businesses += businesses
      
      self.loadingMoreView!.stopAnimating()
      self.isMoreDataLoading = false
      
      self.businessTableView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchTerm = searchBar.text ?? searchTerm
    performSearch()
  }
}