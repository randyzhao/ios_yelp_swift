//
//  FiltersTableViewCell.swift
//  Yelp
//
//  Created by randy_zhao on 5/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersCellDelegate {
    optional func FiltersCell(filtersCell: FiltersTableViewCell, didChangeValue value: Bool)
}

class FiltersTableViewCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: FiltersCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onSwitch.addTarget(self, action: #selector(switchValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }

    func switchValueChanged() {
        print("switch value changed")
        delegate?.FiltersCell?(self, didChangeValue: onSwitch.on)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
