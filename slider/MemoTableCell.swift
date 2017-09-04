//
//  MemoTableCell.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 22..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit

class MemoTableCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet var ctt: UILabel!
    @IBOutlet var reg_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
