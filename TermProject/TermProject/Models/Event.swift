//
//  Event.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import Foundation

class Event: Encodable, Decodable {
    
    let id: String
    let hostId: String
    let hostName: String
    let hostSurname: String
    let title: String
    let beginningTime: Date
    let endingTime: Date
    let place: String
    let detail: String
    let eventType: String
    let attendees: [String]
    let createdTime: Date
    
    init(id: String, hostId: String, hostName: String, hostSurname: String, title: String, beginningTime: Date, endingTime: Date, place: String, detail: String, eventType: String, attendees: [String], createdTime: Date) {
        self.id = id
        self.hostId = hostId
        self.hostName = hostName
        self.hostSurname = hostSurname
        self.title = title
        self.beginningTime = beginningTime
        self.endingTime = endingTime
        self.place = place
        self.detail = detail
        self.eventType = eventType
        self.attendees = attendees
        self.createdTime = createdTime
    }
    
}
