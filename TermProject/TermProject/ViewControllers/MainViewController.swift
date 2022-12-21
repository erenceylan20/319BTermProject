//
//  ViewController.swift
//  TermProject
//
//  Created by Serkan Berk Bilgiç on 19.12.2022.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var eventListTableView: UITableView!
    

    @IBOutlet weak var addUIBarButtonItem: UIBarButtonItem!
    
    
    let eventDataSource = EventDataSource()
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testLabel.text = "New Text"
        self.title = "Events"
    }


}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDataSource.getNumberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        if let event = eventDataSource.getEvent(for: indexPath.row) {
            cell.hostLabel.text = "\(event.hostName) \(event.hostSurname)"
            cell.titleLabel.text = "\(event.title)"
            cell.placeLabel.text = "\(event.place)"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm - dd/MM"
            let beginningTime = formatter.string(from: event.beginningTime)
            let endingTime = formatter.string(from: event.endingTime)
            
            cell.beginningTimeLabel.text = "\(beginningTime)"
            cell.endingTimeLabel.text = "\(endingTime)"
        } else {
            cell.hostLabel.text = ""
            cell.titleLabel.text = ""
            cell.placeLabel.text = ""
            cell.beginningTimeLabel.text = ""
            cell.endingTimeLabel.text = ""
        }
        
        return cell
    }
    
    
}
