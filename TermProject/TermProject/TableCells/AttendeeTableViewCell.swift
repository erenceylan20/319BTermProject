//
//  AttendeeTableViewCell.swift
//  TermProject
//
//  Created by Eren Ceylan on 8.01.2023.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
