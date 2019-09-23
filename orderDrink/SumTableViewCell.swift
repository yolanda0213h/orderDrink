//
//  SumTableViewCell.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/9/16.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class SumTableViewCell: UITableViewCell {

    @IBOutlet weak var sumButton: UIButton!
    @IBOutlet weak var cupXLabel: UILabel!
    @IBOutlet weak var cupYLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
