//
//  AttendeesViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 8.01.2023.
//

import UIKit

class AttendeesViewController: UIViewController {
    
    
    @IBOutlet weak var attendeesTableView: UITableView!
    
    var attendees: [Attendee] = []
    var delegate: EventDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AttendeesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeeCell") as? AttendeeTableViewCell else {
            return UITableViewCell()
        }
        
        let attendee = attendees[indexPath.row]
        cell.nameLabel.text = "\(attendee.name) \(attendee.surname)"
        

        
        return cell
    }
    
    
}
