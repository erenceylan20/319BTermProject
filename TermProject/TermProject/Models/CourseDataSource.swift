//
//  CourseDataSource.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import Foundation


class CourseDataSource {
    
    let weekDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    private var courseArray: [[Course]] = [
        [
        Course(id: "1", title: "Linear Algebra", code: "ENGR200", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Software Engineering", code: "COMP302", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Mobile App Develpoment", code: "COMP319B", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Managerial Accounting", code: "ACCT202", beginningTime: Date(), endingTime: Date()),
        ],
        [
        Course(id: "1", title: "Operating Systems", code: "COMP304", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Academic Writing", code: "ACWR106", beginningTime: Date(), endingTime: Date()),
        ],
        [
        Course(id: "1", title: "Linear Algebra", code: "ENGR200", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Software Engineering", code: "COMP302", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Mobile App Develpoment", code: "COMP319B", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Managerial Accounting", code: "ACCT202", beginningTime: Date(), endingTime: Date()),
        ],
        [
        Course(id: "1", title: "Operating Systems", code: "COMP304", beginningTime: Date(), endingTime: Date()),
        Course(id: "1", title: "Academic Writing", code: "ACWR106", beginningTime: Date(), endingTime: Date()),
        ],
        [],
        [],
        []

        ]
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    //var delegate: CourseDataDelegate?
    
    init() {
        
        
    }
    
    
    func getNumberOfCourses() -> Int {
        var tot = 0
        for array in courseArray {
            tot += array.count
        }
        return tot
    }
    
    func getNumberOfCourses(day: Int) -> Int {
        return courseArray[day].count
    }
    
    func getWeekDayName(day: Int) -> String {
        return weekDays[day]
    }

    
    func getCourse(day: Int, index:Int) -> Course? {
        guard day < courseArray.count else {
            return nil
        }
        guard index < courseArray[day].count else {
            return nil
        }
        
        return courseArray[day][index]
    }
    
}
