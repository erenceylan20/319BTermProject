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
    private static var courseArray: [[Course]] = [[], [], [], [], [], [], []]
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    //var delegate: CourseDataDelegate?
    
    public static var courseDelegate: CourseDataDelegate?
    
    init() {
        self.setCourses()
    }
    
    func setCourses() {
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").getDocuments { document, error in
            if error != nil {
                print("get courses error")
            }else {
                CourseDataSource.courseArray = [[], [], [], [], [], [], []]
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
                CourseDataSource.courseDelegate?.courseArrayLoaded()
            }
        }
        self.sortCourseArray()
        
    }
    func appendCourseMatrix(course: Course) {
        for days in CourseDataSource.courseArray {
            for oldCourse in days {
                if oldCourse.title == course.title {
                    return
                }
            }
        }
        switch(course.day) {
            case "Monday":
                CourseDataSource.courseArray[0].append(course)
                return
            case "Tuesday":
                CourseDataSource.courseArray[1].append(course)
                return
            case "Wednesday":
                CourseDataSource.courseArray[2].append(course)
                return
            case "Thursday":
                CourseDataSource.courseArray[3].append(course)
                return
            case "Friday":
                CourseDataSource.courseArray[4].append(course)
                return
            case "Saturday":
                CourseDataSource.courseArray[5].append(course)
                return
            case "Sunday":
                CourseDataSource.courseArray[6].append(course)
                return
        default:
            print("An unknown error occured!!!!")
        }
        self.sortCourseArray()
    }
    
    func deleteCourse(course: Course) {
        /*
        for i in 0...CourseDataSource.courseArray.count-1 {
            if CourseDataSource.courseArray[i].count > 0 {
                for num in 0...CourseDataSource.courseArray[i].count-1{
                    print("i: \(i), num: \(num), courseArray: \(CourseDataSource.courseArray[i].count)")
                    if CourseDataSource.courseArray[i][num].title == course.title {
                        CourseDataSource.courseArray[i].remove(at: num)
                        break
                    }
                }
            }
            
        }
         */
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
                CourseDataSource.courseDelegate?.courseArrayLoaded()
            }
            self.setCourses()
        }
    }
    
    func addNewCourse(course: Course) {
        //print("DB tarafına geldi")
        self.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("courses").addDocument(data: [
            "id": db.collection("users").document(Auth.auth().currentUser?.uid ?? "").documentID,
            "title": course.title,
            "code": course.code,
            "day": course.day,
            "beginningTime": course.beginningTime,
            "endingTime": course.endingTime
        ])
        self.setCourses()
    }
    
    func getTotalNumberOfCourses() -> Int {
            var tot = 0
            for array in CourseDataSource.courseArray {
                tot += array.count
            }
            return tot
    }
    
    func getNumberOfCoursesInADay(day: Int) -> Int {
        return CourseDataSource.courseArray[day].count
    }
    func getCourse(day: Int, index:Int) -> Course? {
        guard day < CourseDataSource.courseArray.count else {
                return nil
            }
        guard index < CourseDataSource.courseArray[day].count else {
                return nil
            }
            
        return CourseDataSource.courseArray[day][index]
    }
    
    func getCourseArray() ->[[Course]] {
        return CourseDataSource.courseArray
    }
    
    func getWeekDayName(day: Int) -> String {
            return weekDays[day]
    }
    
    func sortCourseArray() {
        for i in 0...CourseDataSource.courseArray.count-1 {
            if CourseDataSource.courseArray[i].count > 0 {
                CourseDataSource.courseArray[i].sort {
                    $0.beginningTime < $1.beginningTime
                }
            }
            
        }
    }
}

