//
//  EventDataSource.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class EventDataSource {
    
    let db = Firestore.firestore()
    var user: [String: String] = ["uid": "", "firstName": "", "lastName": ""]
    
    private var eventArray: [Event] = []
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    private var id = 5
    static var delegate: EventDataDelegate?
    
    init() {
        setUser()
    }
    
    func getEvent(with id: String) -> Event? {
        
        return eventArray.first(where: {$0.id == id})
        
    }
    
    func getNumberOfEvents() -> Int {
        return eventArray.count
    }

    
    func getEvent(for index: Int) -> Event? {
        guard index < eventArray.count else {
            return nil
        }
        
        return eventArray[index]
    }
    
    func setId() -> String {
        id = id + 1
        return "\(id)"
    }
    
    func addNewData(event: Event) {
        let temp = [
            "id": event.id,
            "hostId": event.hostId,
            "hostName": event.hostName,
            "hostSurname": event.hostSurname,
            "title": event.title,
            "beginningTime": event.beginningTime,
            "endingTime": event.endingTime,
            "place": event.place,
            "detail": event.detail,
            "eventType": event.eventType,
            "attendees": event.attendees,
            "createdTime": Date()
        ] as [String : Any]
        db.collection("events")
            .addDocument(data: temp) 
        
    }
    
    func setUser() {
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { snapshot, error in
            if error != nil {
                
            } else {
 
                snapshot?.documents.map({ d in
                    self.user["uid"] = Auth.auth().currentUser?.uid
                    self.user["firstName"] = d["firstName"] as? String ?? "Unknown"
                    self.user["lastName"] = d["lastName"] as? String ?? "Unknown"
                })

            }
            
        }
    }
    
    func deleteEvent(event: Event?) {
        self.db.collection("events").document("\(event?.id ?? "")").delete()
    }
    
    func fetchEvents() {
        db.collection("events").getDocuments() { (querySnapshot, error) in
                                if let error = error {
                                        print("Error getting documents: \(error)")
                                } else {
                                        self.eventArray = []
                                        for document in querySnapshot!.documents {
                                            let data = document.data()
                                            let beginngTime = data["beginningTime"] as? Timestamp
                                            let endingTime = data["endingTime"] as?  Timestamp
                                            let createdTime = data["createdTime"] as? Timestamp
                                            let event = Event(id: document.documentID,
                                                              hostId: data["hostId"] as? String ?? "",
                                                              hostName: data["hostName"] as? String ?? "",
                                                              hostSurname: data["hostSurname"] as? String ?? "",
                                                              title: data["title"] as? String ?? "",
                                                              beginningTime: beginngTime?.dateValue() ?? Date(),
                                                              endingTime: endingTime?.dateValue() ?? Date(),
                                                              place: data["place"] as? String ?? "",
                                                              detail: data["detail"] as? String ?? "",
                                                              eventType: data["eventType"] as? String ?? "",
                                                              attendees: data["attendees"] as? [String] ?? [],
                                                              createdTime: createdTime?.dateValue() ?? Date())
                                            self.eventArray.append(event)
                                        }
                                    self.eventArray = self.eventArray.sorted(by: {
                                        $0.createdTime.compare($1.createdTime) == .orderedDescending
                                    })
                                        EventDataSource.delegate?.eventListUpdated()
                                }
                }
    }
    
    func updateEvent(event: Event?) {
        
        db.collection("events").getDocuments() { (querySnapshot, error) in
                                if let error = error {
                                        print("Error getting documents: \(error)")
                                } else {
                                        for document in querySnapshot!.documents {
                                            if event?.id == document.documentID {
                                                var array = document.data()["attendees"] as? [String] ?? []
                                                let userId = Auth.auth().currentUser?.uid ?? ""
                                                
                                                if !array.contains(userId) {
                                                    array.append(userId)
                                                    document.reference.updateData([
                                                                    "attendees": array
                                                    ])
                                                }
                                                
                                                return
                                                
                                            }
                                            
                                        }
                                    
                                }
                }

    }
    
    func checkIfJoined(event: Event?) -> Bool {
        var checker = false
        db.collection("events").getDocuments() { (querySnapshot, error) in
                                if let error = error {
                                        print("Error getting documents: \(error)")
                                } else {
                                        for document in querySnapshot!.documents {
                                            if event?.id == document.documentID {
                                                let array = document.data()["attendees"] as? [String] ?? []
                                                let userId = Auth.auth().currentUser?.uid ?? ""
                                                if array.contains(userId) {
                                                    checker = true
                                                }
                                                return
                                                
                                            }
                                            
                                        }
                                    
                                }
                }
        return checker
        

    }
    
    func getUser() -> [String: String]{
        return self.user
    }
    
}
