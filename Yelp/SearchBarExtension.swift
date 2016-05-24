//
//  SearchBarExtension.swift
//  Yelp
//
//  Created by randy_zhao on 5/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

extension BusinessViewController: UISearchBarDelegate {
  func performSearch() {
    let searchText = searchBar.text ?? ""
    if searchText == "" {
      searchFilteredBusinesses = businesses
    } else {
      searchFilteredBusinesses = self.businesses.filter({
        (business: Business) -> Bool in
        return business.name?.lowercaseString.containsString(searchText.lowercaseString) ?? false
      })
    }
    businessTableView.reloadData()
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    performSearch()
  }
}