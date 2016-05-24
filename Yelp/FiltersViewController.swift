//
//  FiltersViewController.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
  func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters)
}

private let DealSection = 0
private let CategorySection = 3
private let SortModeSection = 2
private let DistanceSection = 1

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersCellDelegate {
  
  @IBOutlet weak var mainNavigationBar: UINavigationBar!
  @IBOutlet weak var filtersTableView: UITableView!
  
  var searchButton: UIBarButtonItem!
  var cancelButton: UIBarButtonItem!
  
  var categories: [[String: String]] = YelpClient.categories
  var sortModes = YelpClient.sortModes
  var distances = YelpClient.distances
  
  var switchStates = [Int: Bool]()
  
  var delegate: FiltersViewControllerDelegate?
  
  var filters = Filters(filters: Filters.sharedInstance)
  
  var sortModeOpened = false
  
  var distanceSectionHandler: ExpandableTableViewSectionHandler<Int?>!
  var sortModeSectionHandler: ExpandableTableViewSectionHandler<YelpSortMode>!
  
  var seeingAll = false
  let RowCountWhenNotSeeingAll = 3
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Filters"
    searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onSearchBttton))
    cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onCancelButton))
    navigationItem.leftBarButtonItem = cancelButton
    navigationItem.rightBarButtonItem = searchButton
    
    filtersTableView.registerNib(UINib(nibName: "FiltersTableViewCell", bundle: nil), forCellReuseIdentifier: "switchCell")
    filtersTableView.registerNib(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "dropdownCell")
    filtersTableView.registerNib(UINib(nibName: "CheckTableViewCell", bundle: nil), forCellReuseIdentifier: "checkableCell")
    
    filtersTableView.estimatedRowHeight = 100
    filtersTableView.rowHeight = UITableViewAutomaticDimension
    filtersTableView.dataSource = self
    filtersTableView.delegate = self
    
    distanceSectionHandler = ExpandableTableViewSectionHandler<Int?>(tableView: filtersTableView, section: DistanceSection, selectedIndex: getDistanceIndexFromDistance(filters.distance), sectionData: distances, valueSelected: {
      (value: Int?) -> Void in
      self.filters.distance = value
    })
    
    sortModeSectionHandler = ExpandableTableViewSectionHandler<YelpSortMode>(tableView: filtersTableView, section: SortModeSection, selectedIndex: getSortModeIndexFromMode(filters.sort), sectionData: sortModes, valueSelected: {
      (value: YelpSortMode) -> Void in
      self.filters.sort = value
    })
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    filters = Filters(filters: Filters.sharedInstance)
    distanceSectionHandler.selectedIndex = getDistanceIndexFromDistance(filters.distance)
  }
  
  func onCancelButton(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func onSearchBttton(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
    
    delegate?.filtersViewController(self, didUpdateFilters: filters)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == DealSection {
      return 1
    }
    
    if section == CategorySection {
      if seeingAll {
        return categories.count
      } else {
        return RowCountWhenNotSeeingAll + 1
      }
    }
    
    if section == SortModeSection {
      return sortModeSectionHandler.getRowCount()
    }
    
    if section == DistanceSection {
      return distanceSectionHandler.getRowCount()
    }
    
    return 0
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == DealSection {
      return "Deal"
    }
    
    if section == CategorySection {
      return "Categories"
    }
    
    if section == SortModeSection {
      return "Sort By"
    }
    
    if section == DistanceSection {
      return "Distance"
    }
    
    return "Error"
  }
  
  func FiltersCell(filtersCell: FiltersTableViewCell, didChangeValue value: Bool) {
    let indexPath = filtersTableView.indexPathForCell(filtersCell)!
    
    if indexPath.section == DealSection {
      filters.deal = value
    }
    
    if indexPath.section == CategorySection {
      let code = categories[indexPath.row]["code"]!
      if value == true {
        filters.categories.insert(code)
      } else {
        filters.categories.remove(code)
      }
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let section = indexPath.section
    let row = indexPath.row
    
    if section == CategorySection && !seeingAll && row == RowCountWhenNotSeeingAll {
      seeingAll = true
      tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    if section == SortModeSection {
      sortModeSectionHandler.onRowSelected(row)
    }
    
    if section == DistanceSection {
      distanceSectionHandler.onRowSelected(row)
    }
  }
  
  private func getSortModeIndexFromMode(mode: YelpSortMode) -> Int {
    return sortModes.indexOf({
      $0.value == mode
    }) ?? 0
  }
  
  private func getDistanceIndexFromDistance(distance: Int?) -> Int {
    return distances.indexOf({
      $0.value == distance
    }) ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let section = indexPath.section
    let row = indexPath.row
    
    if section == DealSection {
      let cell = filtersTableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! FiltersTableViewCell
      cell.switchLabel.text = "Offering a deal"
      cell.onSwitch.on = filters.deal
      cell.delegate = self
      return cell
    }
    
    if section == CategorySection {
      if row < RowCountWhenNotSeeingAll || seeingAll {
        let cell = filtersTableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! FiltersTableViewCell
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.onSwitch.on = filters.categories.contains(categories[indexPath.row]["code"]!)
        cell.delegate = self
        return cell
      } else {
        let cell = UITableViewCell()
        cell.textLabel!.text = "See All"
        return cell
      }
    }
    
    if section == SortModeSection {
      return sortModeSectionHandler.getTableViewCell(indexPath)
    }
    
    if section == DistanceSection {
      return distanceSectionHandler.getTableViewCell(indexPath)
    }
    
    return UITableViewCell()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
