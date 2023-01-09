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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var attendeesButton: UIButton!
    
    var delegate: MainViewController?
    
    //var eventID: String?
    let eventDataSource = EventDataSource()

    var event: Event?
    var attendees: [Attendee] = []
    
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
            
                detailLabel.text = event.detail
            
                eventDataSource.setAttendees(userIDs: event.attendees)
            
        } else {
            typeImageView.image = nil
            hostLabel.text = ""
            titleLabel.text = ""
            placeLabel.text = ""
            beginningTimeLabel.text = ""
            endingTimeLabel.text = ""
            detailLabel.text = ""
            joinButton.isHidden = true
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? AttendeesViewController {
            destination.delegate = self
            destination.attendees = eventDataSource.getAttendees()
        }
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

