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
    var user: [String: Any] = ["uid": "", "firstName": "", "lastName": ""]
    var attendees: [Attendee] = []
    
    
    private static var eventArray: [Event] = []
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    private var id = 5
    static var delegate: EventDataDelegate?
    
    init() {
        setUser()
    }
    
    func getEvent(with id: String) -> Event? {
        
        return EventDataSource.eventArray.first(where: {$0.id == id})
        
    }
    
    func getNumberOfEvents() -> Int {
        return EventDataSource.eventArray.count
    }

    
    func getEvent(for index: Int) -> Event? {
        guard index < EventDataSource.eventArray.count else {
            return nil
        }
        
        return EventDataSource.eventArray[index]
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
        self.fetchEvents()
        
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
                                        EventDataSource.eventArray = []
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
                                            EventDataSource.eventArray.append(event)
                                        }
                                    EventDataSource.eventArray = EventDataSource.eventArray.sorted(by: {
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
                                                self.fetchEvents()
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
    
    func setAttendees(userIDs: [String]) {
        
        self.attendees = []
        
        db.collection("users").getDocuments() { (querySnapshot, error) in
                                if let error = error {
                                        print("Error getting documents: \(error)")
                                } else {
                                        for document in querySnapshot!.documents {
                                            if userIDs.contains(document.data()["uid"] as? String ?? "") {
                                                self.attendees.append(Attendee(name: document.data()["firstName"] as? String ?? "",
                                                                          surname: document.data()["lastName"] as? String ?? ""))
                                            }
                                            
                                        }
                                    
                                }
                }
        
    }
    
    func getAttendees() -> [Attendee] {
        return attendees
    }
    
    func getUser() -> [String: Any]{
        return self.user
    }
    
}
