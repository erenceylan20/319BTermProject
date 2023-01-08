//
//  CoursesViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 1.01.2023.
//

import UIKit

class CoursesViewController: UIViewController {
    
    
    @IBOutlet weak var courseListTableView: UITableView!

    let refreshControl = UIRefreshControl()
    let courseDataSource = CourseDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Courses"
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        courseListTableView.addSubview(refreshControl)
        
        courseDataSource.courseDelegate = self
    }
   
    
    @objc func refresh(_ sender: AnyObject) {
            self.courseDataSource.setCourses()
            self.courseListTableView.reloadData()
            refreshControl.endRefreshing()
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
        
        return courseDataSource.getNumberOfCoursesInADay(day: section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseTableViewCell else {
            return UITableViewCell()
        }
        
        print("section: \(indexPath.section) row: \(indexPath.row)")
        if let course = courseDataSource.getCourse(day: indexPath.section, index: indexPath.row) {
            cell.courseLabel.text = "\(course.title)"

            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let beginningTime = formatter.string(from: course.beginningTime)
            let endingTime = formatter.string(from: course.endingTime)

            cell.timeLabel.text = "\(beginningTime) - \(endingTime)"


        } else {
            print("Error while getting courses")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { _, _, completionHandler in
            
            completionHandler(true)
            if let course = self.courseDataSource.getCourse(day: indexPath.section, index: indexPath.row) {
                self.courseDataSource.deleteCourse(course: course)
                self.courseListTableView.reloadData()
            }
            
           
        }
        deleteAction.backgroundColor = .systemRed
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseDataSource.getWeekDayName(day: section)
        
    }
    
    
    
}

extension CoursesViewController: CourseDataDelegate {
    func courseArrayLoaded() {
        self.courseDataSource.setCourses()
        self.courseListTableView.reloadData()
    }
    
    func courseArrayUpdated() {
        //self.courseListTableView.reloadData()
        //self.courseDataSource.setCourses()
        self.courseListTableView.reloadData()
    }
}
