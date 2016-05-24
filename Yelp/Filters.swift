//
//  Filter.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

private var _sharedInstance = Filters()

class Filters {
  var deal: Bool = false
  var sort: YelpSortMode = YelpSortMode.BestMatched
  var distance: Int?
  var categories = Set<String>()

  init() { }
  init(filters: Filters) {
    self.deal = filters.deal
    self.sort = filters.sort
    for category in filters.categories {
      self.categories.insert(category)
    }
    self.distance = filters.distance
  }
  
  class var sharedInstance: Filters {
    get {
      return _sharedInstance
    }
    set {
      _sharedInstance = newValue
    }
  }
}