//
//  CheckTableViewCell.swift
//  Yelp
//
//  Created by randy_zhao on 5/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

  @IBOutlet weak var checkStatusImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}
