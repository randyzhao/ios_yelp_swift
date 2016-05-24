//
//  ExpandableTableViewSectionHandler.swift
//  Yelp
//
//  Created by randy_zhao on 5/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

class ExpandableTableViewSectionHandler<ValueType> {
  var sectionOpened = false
  let section: Int!
  var selectedIndex = 0
  var valueSelected: ((value: ValueType) -> Void)
  var sectionData: [(name: String, value: ValueType)]
  let tableView: UITableView!
  
  init(tableView: UITableView, section: Int, selectedIndex: Int, sectionData: [(name: String, value: ValueType)], valueSelected: (value: ValueType) -> Void) {
    self.tableView = tableView
    self.sectionData = sectionData
    self.valueSelected = valueSelected
    self.section = section
  }
  
  func getRowCount() -> Int {
    return sectionOpened ? sectionData.count : 1
  }
  
  func onRowSelected(row: Int) {
    if sectionOpened {
      sectionOpened = false
      valueSelected(value: sectionData[row].value)
      selectedIndex = row
    } else {
      sectionOpened = true
    }
    tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Automatic)
  }
  
  func getTableViewCell(indexPath: NSIndexPath) -> UITableViewCell {
    let row = indexPath.row
    
    if sectionOpened {
      let cell = tableView.dequeueReusableCellWithIdentifier("checkableCell", forIndexPath: indexPath) as! CheckTableViewCell
      cell.nameLabel.text = sectionData[row].name
      let imageName = selectedIndex == row ? "checked" : "unchecked"
      cell.checkStatusImageView.image = UIImage(named: imageName)
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("dropdownCell", forIndexPath: indexPath) as! DropdownTableViewCell
      cell.nameLabel.text = sectionData[selectedIndex].name
      return cell
    }
  }
}