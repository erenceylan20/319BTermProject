//
//  CoursesViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 1.01.2023.
//

import UIKit

class CoursesViewController: UIViewController {
    
    
    @IBOutlet weak var courseListTableView: UITableView!
    
    let courseDataSource = CourseDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Courses"
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

extension CoursesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseDataSource.getNumberOfCourses(day: section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseTableViewCell else {
            return UITableViewCell()
        }
        
        
        if let course = courseDataSource.getCourse(day: indexPath.section, index: indexPath.row) {
            cell.courseLabel.text = "\(course.title)"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let beginningTime = formatter.string(from: course.beginningTime)
            let endingTime = formatter.string(from: course.endingTime)
            
            cell.timeLabel.text = "\(beginningTime) - \(endingTime)"
            
        
        } else {
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseDataSource.getWeekDayName(day: section)
    }
    
    
}
