//
//  AddCourseViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import UIKit

class AddCourseViewController: UIViewController {

    
    @IBOutlet weak var titleHelperLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var codeHelperLabel: UILabel!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var beginningTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var endingTimeDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var addCourseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.placeholder = "Title"
        codeTextField.placeholder = "Course Code"
    }
    
    
    @IBAction func addCourse(_ sender: Any) {
        
        titleHelperLabel.text = "Title"
        titleHelperLabel.textColor = UIColor.black
        codeHelperLabel.text = "Course Code"
        codeHelperLabel.textColor = UIColor.black
        
        
        if let title = titleTextField.text,
           let code = codeTextField.text {
            
            if title.isEmpty || code.isEmpty {
                if title.isEmpty {
                    titleHelperLabel.text = "Title not given!"
                    titleHelperLabel.textColor = UIColor.red
                }
                if code.isEmpty {
                    codeHelperLabel.text = "Course code not given!"
                    codeHelperLabel.textColor = UIColor.red
                }
            } else if title.count > 20 || code.count > 20 {
                if title.count > 20 {
                    titleHelperLabel.text = "Title too long!"
                    titleHelperLabel.textColor = UIColor.red
                }
                if code.count > 20 {
                    codeHelperLabel.text = "Course code too long!"
                    codeHelperLabel.textColor = UIColor.red
                }
            } else {
                
                
                self.dismiss(animated: true)
            }
        }
        
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
