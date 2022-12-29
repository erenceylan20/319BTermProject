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
        self.title = "Events"
        eventDataSource.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? EventTableViewCell,
           let indexPath = eventListTableView.indexPath(for: cell),
           let event = eventDataSource.getEvent(for: indexPath.row),
           let detailController = segue.destination as? EventDetailViewController {
            detailController.eventID = event.id
        }
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
            //let beginningTime = formatter.string(from: event.beginningTime)
            //let endingTime = formatter.string(from: event.endingTime)
            
            cell.typeImageView.image = UIImage(named: event.eventType)
        
        } else {
            cell.hostLabel.text = ""
            cell.titleLabel.text = ""
            cell.placeLabel.text = ""
        }
        
        return cell
    }
    
    
}

extension MainViewController: EventDataDelegate {
    func eventListUpdated() {
        self.eventListTableView.reloadData()
    }
}
