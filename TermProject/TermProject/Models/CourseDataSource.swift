//
//  CourseDataSource.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class CourseDataSource {
    
    let weekDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let db = Firestore.firestore()
    
    //var user : [String: Any] = ["uid": "", "firstName": "", "lastName": "", "courses": []]
    private var courseArray: [[Course]] = [[], [], [], [], [], [], []]
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    //var delegate: CourseDataDelegate?
    
    public var courseDelegate: CourseDataDelegate?
    
    init() {
        self.setCourses()
    }
    
    func setCourses() {
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").getDocuments { document, error in
            if error != nil {
                print("get courses error")
            }else {
                self.courseArray = [[], [], [], [], [], [], []]
                for doc in document!.documents {
                    let data = doc.data()
                    let beginngTime = data["beginningTime"] as? Timestamp
                    let endingTime = data["endingTime"] as?  Timestamp
                    
                    let course = Course(id: data["id"] as? String ?? "",
                                        title: doc["title"] as? String ?? "",
                                        code: doc["code"] as? String ?? "",
                                        day: doc["day"] as? String ?? "",
                                        beginningTime: beginngTime?.dateValue() ?? Date(),
                                        endingTime: endingTime?.dateValue() ?? Date()
                    )
                    self.appendCourseMatrix(course: course)
                }
                
                
                
            }
        }
        self.sortCourseArray()
        
    }
    func appendCourseMatrix(course: Course) {
        for days in courseArray {
            for oldCourse in days {
                if oldCourse.title == course.title {
                    return
                }
            }
        }
        switch(course.day) {
            case "Monday":
                courseArray[0].append(course)
                return
            case "Tuesday":
                courseArray[1].append(course)
                return
            case "Wednesday":
                courseArray[2].append(course)
                return
            case "Thursday":
                courseArray[3].append(course)
                return
            case "Friday":
                courseArray[4].append(course)
                return
            case "Saturday":
                courseArray[5].append(course)
                return
            case "Sunday":
                courseArray[6].append(course)
                return
        default:
            print("An unknown error occured!!!!")
        }
        self.sortCourseArray()
        self.courseDelegate?.courseArrayUpdated()
    }
    func deleteCourse(course: Course) {
        
        for i in 0...courseArray.count-1 {
            if courseArray[i].count > 0 {
                for num in 0...courseArray[i].count-1{
                    print("i: \(i), num: \(num), courseArray: \(courseArray[i].count)")
                    if courseArray[i][num].title == course.title {
                        courseArray[i].remove(at: num)
                        break
                    }
                }
            }
            
        }
        self.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").getDocuments { document, error in
            if error != nil {
                print("An error occured during deletion")
            }else {
                for doc in document!.documents {
                    let data = doc.data()
                    let title = doc["title"] as? String ?? ""
                    if title == course.title {
                        self.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").document(doc.documentID).delete()
                    }
                    
                }
            }
        }
        self.courseDelegate?.courseArrayUpdated()
       
    }
    func addNewCourse(course: Course) {
        //print("DB tarafına geldi")
        appendCourseMatrix(course: course)
        self.courseDelegate?.courseArrayUpdated()
        self.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").addDocument(data: [
            "id": db.collection("users").document(Auth.auth().currentUser?.uid ?? "").documentID,
            "title": course.title,
            "code": course.code,
            "day": course.day,
            "beginningTime": course.beginningTime,
            "endingTime": course.endingTime
        ])
    }
    
    func getTotalNumberOfCourses() -> Int {
            var tot = 0
            for array in courseArray {
                tot += array.count
            }
            return tot
    }
    
    func getNumberOfCoursesInADay(day: Int) -> Int {
        return courseArray[day].count
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
    
    func getCourseArray() ->[[Course]] {
        return self.courseArray
    }
    
    func getWeekDayName(day: Int) -> String {
            return weekDays[day]
    }
    
    func sortCourseArray() {
        for i in 0...courseArray.count-1 {
            if courseArray[i].count > 0 {
                courseArray[i].sort {
                    $0.beginningTime < $1.beginningTime
                }
            }
            
        }
    }
}

