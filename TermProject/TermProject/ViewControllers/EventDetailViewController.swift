//
//  EventDetailViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import UIKit
import Firebase

class EventDetailViewController: UIViewController {

    
    @IBOutlet weak var typeImageView: UIImageView!
    
    @IBOutlet weak var hostLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var beginningTimeLabel: UILabel!
    
    @IBOutlet weak var endingTimeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var joinButton: UIButton!
    
    
    var delegate: MainViewController?
    
    //var eventID: String?
    let eventDataSource = EventDataSource()

    var event: Event?
    
    var selfEvent: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(eventDataSource.getNumberOfEvents())

       
        if let event = event
             {
                typeImageView.image = UIImage(named: event.eventType)
                hostLabel.text = "\(event.hostName) \(event.hostSurname)"
                titleLabel.text = "\(event.title)"
                placeLabel.text = "\(event.place)"
            
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM - HH:mm"
                let beginningTime = formatter.string(from: event.beginningTime)
                let endingTime = formatter.string(from: event.endingTime)
                
                beginningTimeLabel.text = "\(beginningTime)"
                endingTimeLabel.text = "\(endingTime)"
                
                let userId = (Auth.auth().currentUser?.uid ?? "") as String
            
                if userId == event.hostId {
                    joinButton.setTitle("DELETE", for: .normal)
                    selfEvent = true
                }
            
                detailTextView.text = event.detail
            
        } else {
            typeImageView.image = nil
            hostLabel.text = ""
            titleLabel.text = ""
            placeLabel.text = ""
            beginningTimeLabel.text = ""
            endingTimeLabel.text = ""
            detailTextView.text = ""
            joinButton.isHidden = true
        }
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    @IBAction func joinClicked(_ sender: Any) {
        if selfEvent {
            eventDataSource.deleteEvent(event: event)
            self.navigationController?.popViewController(animated: true)
        } else {
            eventDataSource.updateEvent(event: event)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}

extension EventDetailViewController: EventDataDelegate {
    
}
