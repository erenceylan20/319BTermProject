//
//  WeekDayTableViewCell.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var weekDayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
