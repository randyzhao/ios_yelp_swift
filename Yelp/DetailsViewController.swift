//
//  DetailsViewController.swift
//  Yelp
//
//  Created by randy_zhao on 5/27/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var reviewsCountLabel: UILabel!
  @IBOutlet weak var businessMapView: MKMapView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  
  var business: Business!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLabel.text = business.name
    distanceLabel.text = business.distance
    reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
    addressLabel.text = "\(business.address!)"
    ratingImageView.setImageWithURL(business.ratingImageURL!)
    
    if business.latitude != nil && business.longitude != nil {
      businessMapView.centerCoordinate = CLLocation(latitude: business.latitude!, longitude: business.longitude!).coordinate
    }
    let coordinate = CLLocation(latitude: business.latitude!, longitude: business.longitude!).coordinate
    let region = MKCoordinateRegionMakeWithDistance(coordinate,100,100)
    businessMapView.setRegion(region, animated: false)
    let pin = MKPointAnnotation()
    pin.coordinate = coordinate
    pin.title = business.name
    businessMapView.addAnnotation(pin)
    navigationItem.title = "Details"
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.edgesForExtendedLayout = UIRectEdge.None
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
