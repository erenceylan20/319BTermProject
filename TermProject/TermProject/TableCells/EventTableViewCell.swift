//
//  EventTableViewCell.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var hostLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    
    @IBOutlet weak var beginningTimeLabel: UILabel!
    
    @IBOutlet weak var endingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
