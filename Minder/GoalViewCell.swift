//
//  GoalViewCell.swift
//  Minder
//
//  Created by Nikki Ivie on 11/7/18.
//  Copyright © 2018 Haptic Technologies, LLC. All rights reserved.
//
//

import UIKit

class GoalViewCell: UITableViewCell {

    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var percentCompleteLabel: UILabel!
    @IBOutlet weak var goalIsComplete: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
