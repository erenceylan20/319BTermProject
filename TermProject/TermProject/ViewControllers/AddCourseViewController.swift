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
    

    @IBOutlet weak var dropDownDayMenu: UIPickerView!
    @IBOutlet weak var beginningTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var endingTimeDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var addCourseButton: UIButton!
    
    let courseDataSource = CourseDataSource()
    
    let pickerViewSource = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedValue: String = "Monday"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropDownDayMenu.delegate = self
        dropDownDayMenu.dataSource = self
        
        titleTextField.placeholder = "Title"
        codeTextField.placeholder = "Course Code"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func addCourse(_ sender: Any) {
        

        titleHelperLabel.text = "Title"
        titleHelperLabel.textColor = UIColor.black
        codeHelperLabel.text = "Course Code"
        codeHelperLabel.textColor = UIColor.black
        
        //var selectedValue = pickerViewSource[pickerView.selectedRowInComponent(0)]

        if let title = titleTextField.text,
           let code = codeTextField.text{
            print(selectedValue)
            
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
                
                let course = Course(id: "", title: title, code: code, day: selectedValue, beginningTime: beginningTimeDatePicker.date, endingTime: endingTimeDatePicker.date)
                courseDataSource.addNewCourse(course: course)
                self.dismiss(animated: true, completion: nil)
            
               
            }
        }
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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

extension AddCourseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return pickerViewSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
            // use the row to get the selected row from the picker view
            // using the row extract the value from your datasource (array[row])
           self.selectedValue = pickerViewSource[row]
        }
    
}

