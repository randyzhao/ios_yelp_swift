//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
  var business: Business! {
    didSet {
      nameLabel.text = business.name
      if business.imageURL != nil {
        thumbImageView.setImageWithURL(business.imageURL!)
      }
      categoriesLabel.text = business.categories
      reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
      ratingImageView.setImageWithURL(business.ratingImageURL!)
      distanceLabel.text = business.distance
      addressLabel.text = "\(business.address!)"
    }
  }
  
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  @IBOutlet weak var reviewsCountLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    thumbImageView.layer.cornerRadius = 5
    thumbImageView.clipsToBounds = true
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
