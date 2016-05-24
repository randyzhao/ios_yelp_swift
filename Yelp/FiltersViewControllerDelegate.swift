//
//  FiltersViewControllerDelegate.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
}