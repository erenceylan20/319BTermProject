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
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
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
