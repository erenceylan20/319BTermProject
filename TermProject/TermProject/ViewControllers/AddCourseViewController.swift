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
