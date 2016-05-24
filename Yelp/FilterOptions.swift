//
//  FilterOptions.swift
//  Yelp
//
//  Created by randy_zhao on 5/25/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class FilterOption: NSObject {
  var optionDisplayName: String?
  var optionQueryName: String?
  var optionValue: AnyObject?
  var optionQueryValue: AnyObject?
  
  var children = [FilterOption]()
  
  init(optionDisplayName: String? = nil, optionQueryName: String? = nil, optionValue: AnyObject? = nil, optionQueryValue: AnyObject? = nil) {
    super.init()
    
    self.optionDisplayName = optionDisplayName
    self.optionQueryName = optionQueryName
    self.optionValue = optionValue
    self.optionQueryValue = optionQueryValue
  }
  
  var count: Int {
    return children.count
  }
  
  class func categoriesFromFilterOption(option: ExpandableFilterOption) {
    var result = [String]()
    if option.optionQueryName == "categories" {
      for child in option.children {
        if child.optionValue as! Bool {
          result.append(child.optionQueryName!)
        }
      }
    }
  }
}

class SwitchFilterOption: FilterOption {
  
}

class SingleFilterOption: FilterOption {
  
}

enum DropdownStatus {
  case Opened
  case Closed
}

class DropdownFilterOption: FilterOption {
  var status: DropdownStatus = .Closed
  
  init(optionDisplayName: String? = nil, optionQueryName: String? = nil, optionValue: AnyObject? = nil, optionQueryValue: AnyObject? = nil, children: [FilterOption]) {
    super.init(optionDisplayName: optionDisplayName, optionQueryName: optionQueryName, optionValue: optionValue, optionQueryValue: optionQueryValue)
    self.children = children
    if (children.count > 0) {
      self.optionDisplayName = children[0].optionDisplayName
    }
  }
}

enum ExpandableStatus {
  case NotExpanded
  case Expanded
}
class ExpandableFilterOption: FilterOption {
  static let OptionsVisibleWhenNotExpanded = 3
  
  var status: ExpandableStatus = .NotExpanded
}