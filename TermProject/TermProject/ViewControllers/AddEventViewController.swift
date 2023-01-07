//
//  AddEventViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import UIKit


class AddEventViewController: UIViewController {

    
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var placeTextField: UITextField!
    
    @IBOutlet weak var beginningTimeLabel: UILabel!
    
    @IBOutlet weak var beginningDatePicker: UIDatePicker!
    
    @IBOutlet weak var endingTimeLabel: UILabel!
    
    @IBOutlet weak var endingDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var titleHelperLabel: UILabel!
    
    @IBOutlet weak var placeHelperLabel: UILabel!
    
    
    
    let eventDataSource = EventDataSource()
    
    
    
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        titleHelperLabel.text = "Title"
        titleHelperLabel.textColor = UIColor.black
        placeHelperLabel.text = "Place"
        placeHelperLabel.textColor = UIColor.black
        
        
        if let title = titleTextField.text,
           let place = placeTextField.text {
            
            if title.isEmpty || place.isEmpty {
                if title.isEmpty {
                    titleHelperLabel.text = "Title not given!"
                    titleHelperLabel.textColor = UIColor.red
                }
                if place.isEmpty {
                    placeHelperLabel.text = "Place not given!"
                    placeHelperLabel.textColor = UIColor.red
                }
            } else if title.count > 20 || place.count > 20 {
                if title.count > 20 {
                    titleHelperLabel.text = "Title too long!"
                    titleHelperLabel.textColor = UIColor.red
                }
                if place.count > 20 {
                    placeHelperLabel.text = "Place too long!"
                    placeHelperLabel.textColor = UIColor.red
                }
            } else {
                
                
                let user = eventDataSource.getUser()
                
                let event = Event(id: eventDataSource.setId(),
                                  hostId: user["uid"] ?? "",
                                  hostName: user["firstName"] ?? "",
                                  hostSurname: user["lastName"] ?? "",
                                  title: title,
                                  beginningTime: beginningDatePicker.date,
                                  endingTime: endingDatePicker.date,
                                  place: place,
                                  detail: detailTextView.text,
                                  eventType: getImageName(),
                                  attendees: [],
                                  createdTime: Date())
                eventDataSource.addNewData(event: event)
                
                self.dismiss(animated: true)
            }
            
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        titleTextField.placeholder = "Title"
        placeTextField.placeholder = "Place"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        

        let optionsClosure = { (action: UIAction) in
             print(action.title)
           }
           typeButton.menu = UIMenu(children: [
             UIAction(title: "Select Type", state: .on, handler: optionsClosure),
             UIAction(title: "Other", handler: optionsClosure),
             UIAction(title: "Coffee", handler: optionsClosure),
             UIAction(title: "Eat", handler: optionsClosure),
             UIAction(title: "Study", handler: optionsClosure),
             UIAction(title: "Sport", handler: optionsClosure),
             UIAction(title: "Hang Out", handler: optionsClosure),
           ])
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    
    
    func getImageName() -> String {
        let text = typeButton.titleLabel?.text
        
        switch text {
        case "Other": return "optional"
        case "Coffee": return "coffee"
        case "Eat": return "eat"
        case "Study": return "study"
        case "Sport": return "sport"
        case "Hang Out": return "meet"
        default: return "optional"
        }
        
        
    }
    

}


