//
//  SavedGameCell.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 5/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

import UIKit

class SavedGameCell: UITableViewCell {
    
    //Outlets.
    @IBOutlet weak var gameid: UILabel!
    @IBOutlet weak var gametype: UILabel!
    @IBOutlet weak var gameplayers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
