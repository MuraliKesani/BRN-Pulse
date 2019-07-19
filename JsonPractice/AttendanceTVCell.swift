//
//  AttendanceTVCell.swift
//  JsonPractice
//
//  Created by Murali on 7/18/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class AttendanceTVCell: UITableViewCell {
@IBOutlet var listLbl: UILabel!

@IBOutlet var detailLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
