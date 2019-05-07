//
//  HADSTableViewCell.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 18/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit
import DLRadioButton

class HADSTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionA: DLRadioButton!
    @IBOutlet weak var optionB: DLRadioButton!
    @IBOutlet weak var optionC: DLRadioButton!
    @IBOutlet weak var optionD: DLRadioButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
